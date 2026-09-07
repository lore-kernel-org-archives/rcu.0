Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258E4E66D4;
	Mon,  7 Sep 2026 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788771; cv=none; b=KQgmax4xAGdBg7kM3sjq5xU5+ZX2Vtd0v9NxOjl8LnNvs+v+aMFFq8SYzCflCvc0tzaQfw7uGF6EsT+Yu2ky7yqEChAxoT/rSN/UWDC/V1x3IRc2707JhRZN64vpsl1ktlSBsNrdhE6F6Mph8bUvPGhgObO6ldo/8DzguwsGH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788771; c=relaxed/simple;
	bh=uenPT/qyhLlUdFfVNBHnJZrdv8BXxACx/GABezMVEUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbzbmT8Unq5EONaWKyKQ5dO1iPEY2ahELy8bRFvI881in+W/lWy+LAQ0x1wCTqZfKmMMCFdP9zAOThzmHITbZdTnSiuhS4EOoNsOrXR3chWN8+R7uRTq7OHHoUZQvPAetpuHDtRAyR+e4zPTulB+TbuvYEUJX5tLSoM++WRppew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNUFF8oQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNUFF8oQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71341F00A3A;
	Mon,  7 Sep 2026 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788788763;
	bh=cBwesB9lffu6fBm+PBRIUcZqwuSY+znNh69Ji5v2usU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SNUFF8oQP/MlnM/qu2EhZ6GddQ0ETK1joTwfrgeWZaeyha9WDNg3xC7TlNPx5abSX
	 wvNYhWjeaVMAvJByc1foOQgvRPa2apmm8HGzQahR41Lm4Gjul0KH9s8OgUq2vjpaJl
	 zVv/MI6ptnf2CTCCoHoTe7oYdXBZbwAut3TI9KWlRgysOZulmEz/wBAbYwYVvSCogy
	 Eb1Y37j1di5DUMSd4vIm9Eczz4nWHdyfJrxLtPUH4ygVtJ3e/b/tDcoEuHzJTAkvae
	 DfgZzse/RtS2g2xb9MhUgej2LW0eJwv8tiTfvktTeoAMEuKfMwd9XuKhNq5F7huHdH
	 +ZkY74J0D+6WA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH bpf-next 1/4] bpf: Add bpf_call_rcu() kfunc
Date: Mon,  7 Sep 2026 06:45:48 -0700
Message-ID: <20260907134552.1772405-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907134552.1772405-1-puranjay@kernel.org>
References: <20260907134552.1772405-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs that manage their own objects have no way to run their own
logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
free, but returning an index to an allocator or unpinning a resource
once readers are done has no equivalent.  sched_ext's BPF library works
around this today by pushing freed nodes onto a list and having a
userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
BPF program to reclaim them.

Add:

	int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
			 int (*callback)(struct bpf_map *map, void *key,
					 void *value));

@rh is a struct bpf_rcu_head embedded in a value of @map, so the
callback runs as callback(map, key, value) for the element it lives in
and needs no cookie.  A head can only be armed once, which bounds
outstanding work by the number of elements.

An RCU callback cannot be cancelled, so everything it touches has to
stay alive until it runs:

  - The callback is the program's text, so arming takes a program
    reference as bpf_timer, bpf_wq and bpf_task_work do, dropped once
    the callback returns.  bpf_prog_inc_not_zero() also fails the arm
    with -ENOENT once the program is dying.

  - The map is held by that reference through used_maps.  An inner map
    is not, so bpf_rcu_head is rejected in one.

  - The field is only accepted in BPF_MAP_TYPE_ARRAY, whose elements
    are never freed individually.

  - The head is disarmed before the callback runs so it can be armed
    again from there, which takes a new program reference before the
    running callback drops its own.  Arming therefore fails with -EPERM
    once the map is held by neither a process nor bpffs, the same
    policy bpf_timer and bpf_task_work apply.

bpf_iter hands a program a writable pointer to the live element, which
would let it overwrite a queued head, so bpf_iter_attach_map() rejects
maps carrying one.

The callback is verified non-sleepable even when the caller is
sleepable, and RCU invokes it with BH disabled.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h            |  9 ++++
 include/uapi/linux/bpf.h       |  4 ++
 kernel/bpf/btf.c               |  7 +++
 kernel/bpf/helpers.c           | 77 +++++++++++++++++++++++++++++++
 kernel/bpf/map_in_map.c        |  4 ++
 kernel/bpf/map_iter.c          |  6 +++
 kernel/bpf/syscall.c           | 11 ++++-
 kernel/bpf/verifier.c          | 83 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  4 ++
 9 files changed, 202 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e80963971f680..440f559cf1224 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -214,6 +214,7 @@ enum btf_field_type {
 	BPF_UPTR       = (1 << 11),
 	BPF_RES_SPIN_LOCK = (1 << 12),
 	BPF_TASK_WORK  = (1 << 13),
+	BPF_RCU_HEAD   = (1 << 14),
 };
 
 enum bpf_cgroup_storage_type {
@@ -268,6 +269,7 @@ struct btf_record {
 	int wq_off;
 	int refcount_off;
 	int task_work_off;
+	int rcu_head_off;
 	struct btf_field fields[];
 };
 
@@ -373,6 +375,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_refcount";
 	case BPF_TASK_WORK:
 		return "bpf_task_work";
+	case BPF_RCU_HEAD:
+		return "bpf_rcu_head";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -413,6 +417,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(struct bpf_refcount);
 	case BPF_TASK_WORK:
 		return sizeof(struct bpf_task_work);
+	case BPF_RCU_HEAD:
+		return sizeof(struct bpf_rcu_head);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -447,6 +453,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(struct bpf_refcount);
 	case BPF_TASK_WORK:
 		return __alignof__(struct bpf_task_work);
+	case BPF_RCU_HEAD:
+		return __alignof__(struct bpf_rcu_head);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -479,6 +487,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_KPTR_PERCPU:
 	case BPF_UPTR:
 	case BPF_TASK_WORK:
+	case BPF_RCU_HEAD:
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc08d1c..8871217a9d47f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7600,6 +7600,10 @@ struct bpf_task_work {
 	__u64 __opaque;
 } __attribute__((aligned(8)));
 
+struct bpf_rcu_head {
+	__u64 __opaque[8];
+} __attribute__((aligned(8)));
+
 struct bpf_wq {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 31057c8f3a7c2..ae627160152ff 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3695,6 +3695,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 		{ BPF_TIMER, "bpf_timer", true },
 		{ BPF_WORKQUEUE, "bpf_wq", true },
 		{ BPF_TASK_WORK, "bpf_task_work", true },
+		{ BPF_RCU_HEAD, "bpf_rcu_head", true },
 		{ BPF_LIST_HEAD, "bpf_list_head", false },
 		{ BPF_LIST_NODE, "bpf_list_node", false },
 		{ BPF_RB_ROOT, "bpf_rb_root", false },
@@ -3880,6 +3881,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_RB_NODE:
 	case BPF_REFCOUNT:
 	case BPF_TASK_WORK:
+	case BPF_RCU_HEAD:
 		ret = btf_find_struct(btf, var_type, off, sz, field_type,
 				      info_cnt ? &info[0] : &tmp);
 		if (ret < 0)
@@ -4175,6 +4177,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	rec->wq_off = -EINVAL;
 	rec->refcount_off = -EINVAL;
 	rec->task_work_off = -EINVAL;
+	rec->rcu_head_off = -EINVAL;
 	for (i = 0; i < cnt; i++) {
 		field_type_size = btf_field_type_size(info_arr[i].type);
 		if (info_arr[i].off + field_type_size > value_size) {
@@ -4218,6 +4221,10 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			WARN_ON_ONCE(rec->task_work_off >= 0);
 			rec->task_work_off = rec->fields[i].offset;
 			break;
+		case BPF_RCU_HEAD:
+			WARN_ON_ONCE(rec->rcu_head_off >= 0);
+			rec->rcu_head_off = rec->fields[i].offset;
+			break;
 		case BPF_REFCOUNT:
 			WARN_ON_ONCE(rec->refcount_off >= 0);
 			/* Cache offset for faster lookup at runtime */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc8756..609c47e9cc85a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4676,6 +4676,82 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
 	return bpf_task_work_schedule(task, tw, map__const_map, callback, aux, TWA_RESUME);
 }
 
+typedef int (*bpf_rcu_callback_t)(struct bpf_map *map, void *key, void *value);
+
+/* Actual type for struct bpf_rcu_head */
+struct bpf_rcu_head_kern {
+	struct rcu_head rcu;
+	bpf_callback_t callback_fn;
+	struct bpf_map *map;
+	struct bpf_prog *prog;
+	u32 armed;
+} __aligned(8);
+
+static void bpf_rcu_run_callback(struct rcu_head *rcu)
+{
+	struct bpf_rcu_head_kern *rh = container_of(rcu, struct bpf_rcu_head_kern, rcu);
+	bpf_callback_t callback_fn = rh->callback_fn;
+	struct bpf_prog *prog = rh->prog;
+	struct bpf_map *map = rh->map;
+	void *value, *key;
+	u32 idx;
+
+	value = (void *)rh - map->record->rcu_head_off;
+	key = map_key_from_value(map, value, &idx);
+
+	/* Pairs with the arming cmpxchg(): rh may be re-armed as soon as this store lands. */
+	smp_store_release(&rh->armed, 0);
+
+	rcu_read_lock();
+	migrate_disable();
+	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	migrate_enable();
+	rcu_read_unlock();
+
+	bpf_prog_put(prog);
+}
+
+/**
+ * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
+ * @rh: struct bpf_rcu_head in a BPF map value
+ * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the values
+ * @callback: BPF subprogram, invoked as callback(map, key, value) for the value holding @rh
+ * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
+ *
+ * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
+ * nor bpffs, or -ENOENT if the calling program is going away.
+ */
+__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
+			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
+{
+	struct bpf_rcu_head_kern *rhk = (void *)rh;
+	struct bpf_map *map = map__const_map;
+	struct bpf_prog *prog;
+
+	BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf_rcu_head));
+	BUILD_BUG_ON(__alignof__(struct bpf_rcu_head_kern) != __alignof__(struct bpf_rcu_head));
+	BTF_TYPE_EMIT(struct bpf_rcu_head);
+
+	/* A queued callback cannot be cancelled, so a self-rearming one would pin prog and map. */
+	if (!atomic64_read(&map->usercnt))
+		return -EPERM;
+
+	if (cmpxchg(&rhk->armed, 0, 1))
+		return -EBUSY;
+
+	prog = bpf_prog_inc_not_zero(aux->prog);
+	if (IS_ERR(prog)) {
+		WRITE_ONCE(rhk->armed, 0);
+		return PTR_ERR(prog);
+	}
+
+	rhk->callback_fn = (bpf_callback_t)(void *)callback;
+	rhk->map = map;
+	rhk->prog = prog;
+	call_rcu(&rhk->rcu, bpf_rcu_run_callback);
+	return 0;
+}
+
 static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
 			    struct bpf_dynptr_kern *ptr)
 {
@@ -4969,6 +5045,7 @@ BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_call_rcu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index d2cbab4bdf644..5ee8aae7435ba 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -25,6 +25,10 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	if (!inner_map->ops->map_meta_equal)
 		return ERR_PTR(-ENOTSUPP);
 
+	/* An inner map has no used_maps reference to hold it under a queued callback. */
+	if (btf_record_has_field(inner_map->record, BPF_RCU_HEAD))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	inner_map_meta_size = sizeof(*inner_map_meta);
 	/* In some cases verifier needs to access beyond just base map. */
 	if (inner_map->ops == &array_map_ops || inner_map->ops == &percpu_array_map_ops)
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index c19b360bad9ea..8717e63b049a5 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -117,6 +117,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 		goto put_map;
 	}
 
+	/* The value ctx arg is writable and, for a non-percpu map, aliases the live element. */
+	if (btf_record_has_field(map->record, BPF_RCU_HEAD)) {
+		err = -EOPNOTSUPP;
+		goto put_map;
+	}
+
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c7bc9ba9b331f..de286dbf8aa1f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -687,6 +687,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
 		case BPF_TASK_WORK:
+		case BPF_RCU_HEAD:
 			/* Nothing to release */
 			break;
 		default:
@@ -741,6 +742,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
 		case BPF_TASK_WORK:
+		case BPF_RCU_HEAD:
 			/* Nothing to acquire */
 			break;
 		default:
@@ -874,6 +876,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
+		case BPF_RCU_HEAD:
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -1277,7 +1280,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
 				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR |
-				       BPF_TASK_WORK,
+				       BPF_TASK_WORK | BPF_RCU_HEAD,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1319,6 +1322,12 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 					goto free_map_tab;
 				}
 				break;
+			case BPF_RCU_HEAD:
+				if (map->map_type != BPF_MAP_TYPE_ARRAY) {
+					ret = -EOPNOTSUPP;
+					goto free_map_tab;
+				}
+				break;
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
 			case BPF_KPTR_PERCPU:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e79750e24808..e07bb707a99d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -529,6 +529,7 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
 static bool is_async_callback_calling_kfunc(u32 btf_id);
+static bool is_call_rcu_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
 
 static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
@@ -571,6 +572,10 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_timer_set_callback)
 		return false;
 
+	/* bpf_call_rcu callbacks are never sleepable. */
+	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 && is_call_rcu_kfunc(insn->imm))
+		return false;
+
 	/* bpf_wq and bpf_task_work callbacks are always sleepable. */
 	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
 	    (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
@@ -7575,6 +7580,9 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, struct bpf_reg_
 	case BPF_TASK_WORK:
 		field_off = map->record->task_work_off;
 		break;
+	case BPF_RCU_HEAD:
+		field_off = map->record->rcu_head_off;
+		break;
 	case BPF_WORKQUEUE:
 		field_off = map->record->wq_off;
 		break;
@@ -8799,6 +8807,8 @@ static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_stat
 			obj_name = "timer";
 		else if (rec->task_work_off >= 0)
 			obj_name = "bpf_task_work";
+		else if (rec->rcu_head_off >= 0)
+			obj_name = "bpf_rcu_head";
 
 		verbose(env, "%s pointer in %s map_uid=%d ",
 			obj_name, reg_arg_name(env, obj_argno), meta->map.uid);
@@ -10361,6 +10371,36 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int set_rcu_callback_state(struct bpf_verifier_env *env,
+				  struct bpf_func_state *caller,
+				  struct bpf_func_state *callee,
+				  int insn_idx)
+{
+	struct bpf_map *map_ptr = caller->regs[BPF_REG_2].map_ptr;
+
+	/*
+	 * callback_fn(struct bpf_map *map, void *key, void *value);
+	 */
+	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
+	callee->regs[BPF_REG_1].map_ptr = map_ptr;
+
+	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
+	callee->regs[BPF_REG_2].map_ptr = map_ptr;
+
+	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
+	callee->regs[BPF_REG_3].map_ptr = map_ptr;
+
+	/* unused */
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_async_callback_fn = true;
+	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
+	return 0;
+}
+
 static bool is_rbtree_lock_required_kfunc(u32 btf_id);
 
 static void account_processed_insn(struct bpf_verifier_env *env)
@@ -11626,7 +11666,8 @@ enum {
 	KF_ARG_RES_SPIN_LOCK_ID,
 	KF_ARG_TASK_WORK_ID,
 	KF_ARG_PROG_AUX_ID,
-	KF_ARG_TIMER_ID
+	KF_ARG_TIMER_ID,
+	KF_ARG_RCU_HEAD_ID
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -11640,6 +11681,7 @@ BTF_ID(struct, bpf_res_spin_lock)
 BTF_ID(struct, bpf_task_work)
 BTF_ID(struct, bpf_prog_aux)
 BTF_ID(struct, bpf_timer)
+BTF_ID(struct, bpf_rcu_head)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -11698,6 +11740,11 @@ static bool is_kfunc_arg_task_work(const struct btf *btf, const struct btf_param
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TASK_WORK_ID);
 }
 
+static bool is_kfunc_arg_rcu_head(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RCU_HEAD_ID);
+}
+
 static bool is_kfunc_arg_res_spin_lock(const struct btf *btf, const struct btf_param *arg)
 {
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RES_SPIN_LOCK_ID);
@@ -11897,6 +11944,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
 	KF_ARG_PTR_TO_TASK_WORK,
+	KF_ARG_PTR_TO_RCU_HEAD,
 	KF_ARG_PTR_TO_ARENA,
 };
 
@@ -11965,6 +12013,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
+	KF_bpf_call_rcu,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_session_is_return,
@@ -12055,6 +12104,7 @@ BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_call_rcu)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 #ifdef CONFIG_BPF_EVENTS
@@ -12108,6 +12158,11 @@ static bool is_bpf_rbtree_add_kfunc(u32 func_id)
 	       func_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
 
+static bool is_call_rcu_kfunc(u32 func_id)
+{
+	return func_id == special_kfunc_list[KF_bpf_call_rcu];
+}
+
 static bool is_task_work_add_kfunc(u32 func_id)
 {
 	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
@@ -12219,6 +12274,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		arg_type = KF_ARG_PTR_TO_TIMER;
 	else if (is_kfunc_arg_task_work(meta->btf, &args[arg]))
 		arg_type = KF_ARG_PTR_TO_TASK_WORK;
+	else if (is_kfunc_arg_rcu_head(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_RCU_HEAD;
 	else if (is_kfunc_arg_irq_flag(meta->btf, &args[arg]))
 		arg_type = KF_ARG_PTR_TO_IRQ_FLAG;
 	else if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
@@ -12627,7 +12684,8 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 static bool is_async_callback_calling_kfunc(u32 btf_id)
 {
 	return is_bpf_wq_set_callback_kfunc(btf_id) ||
-	       is_task_work_add_kfunc(btf_id);
+	       is_task_work_add_kfunc(btf_id) ||
+	       is_call_rcu_kfunc(btf_id);
 }
 
 bool bpf_is_throw_kfunc(struct bpf_insn *insn)
@@ -13004,6 +13062,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		case KF_ARG_PTR_TO_WORKQUEUE:
 		case KF_ARG_PTR_TO_TIMER:
 		case KF_ARG_PTR_TO_TASK_WORK:
+		case KF_ARG_PTR_TO_RCU_HEAD:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 		case KF_ARG_PTR_TO_ARENA:
@@ -13533,6 +13592,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_RCU_HEAD:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "%s doesn't point to a map value\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			ret = check_map_field_pointer(env, reg, argno, BPF_RCU_HEAD, &meta->map);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 			if (reg->type != PTR_TO_STACK) {
 				verbose(env, "%s doesn't point to an irq flag on stack\n",
@@ -14122,6 +14191,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_call_rcu_kfunc(meta.func_id)) {
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_rcu_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+	}
+
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 732b35cc08d1c..8871217a9d47f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7600,6 +7600,10 @@ struct bpf_task_work {
 	__u64 __opaque;
 } __attribute__((aligned(8)));
 
+struct bpf_rcu_head {
+	__u64 __opaque[8];
+} __attribute__((aligned(8)));
+
 struct bpf_wq {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
-- 
2.53.0-Meta

