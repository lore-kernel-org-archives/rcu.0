Received: from mail-pz2-f21.google.com (mail-pz2-f21.google.com [74.125.228.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D872F0C7E
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041983; cv=none; b=S87lJy9XPIYcIhPOnC3SCQi5eQpgmG1FvgAarp77FcpBkggM0ZvX+N/neJaM/AJfuuPg9w891KenGEN04MEwwczogL4hf7dM4RqqebxmYznrBE41vF/ovGc4nhXEdpSjlIiNxBPFDx8lVajfidNCNIJq61hWBvgrTS3TeHQJktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041983; c=relaxed/simple;
	bh=844BbKCjuK44YIRNTaW+OIbFc5ErzLKeSHq/FS1o2yE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=m2Wxem6gzOjZ9NByVhfMnGxPK5F9OM3A0pzg5Os5U+UvQfz/AqraMgnjQJYEm95R6pAd1N+GBnSa2OteeuZVmQ2KPdve+JzEpPU1DByikEavzrWjuRN4uJmv6/k53Isx6LumBaGwWw3zSAFI+noqeiIMhXU6ul1/mKTMh0ICN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu4j0ZQm; arc=none smtp.client-ip=74.125.228.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu4j0ZQm"
Received: by mail-pz2-f21.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so4025400a12.2
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790041981; x=1790646781; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=seqMOpxiRBW7YE0oJ3UyuQPvImrdU7NqfNAkSFs7Tu0=;
        b=Vu4j0ZQm7UGCLA9BsGySLu6EHnPxXBqWRgv1MGgU2Gzo6seCTAGvV7FoJNbjDVZFF7
         vTqWvI/72FN6rr4fzZMyQZcmLtCDO7Y8bCxjvJ91eG/KhQ/Kk6qFZAdUSOp/3rfwI4C7
         q+J2/UF50IGTlPf3Y+qJlpgSL/OnNb3GxLwOvr9UVwXgfWDws0q1UE+F+larBXVg+bg4
         shk14wvWdxpZWAIcOvHjGzLEzfb793Im4PpF3LAFWVNpX/o1mOhykNZQGQ8pXh/1jaCg
         R8LOEu/wAr6leRjzAm0IJ2wJvyvvihM3NnroHMvZuggC/PIFiXt9nO+sjs6HSnrVXNUn
         TgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790041981; x=1790646781;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seqMOpxiRBW7YE0oJ3UyuQPvImrdU7NqfNAkSFs7Tu0=;
        b=ApU8QP1I3eOrr+8DYcAcioNQVkjil3bcISx76vJNyFmmcilePXuCJBOncKGRlpMpO5
         W2Xl9v9F6NcxknsuQqEeXIJdbO7gY9tR9AYVJr/QiZiqjQ5zvDN7hcSssZmKLsiVUXqz
         ZqA3to0C6KYnk3KJTNvuV1R/gXP2Rsv5Hf4OHhFY5aA6ZRUeaSs3v9ivi2i13MooOmRQ
         l1wiOyFRCg7yqcrdibQIngUVM2dLa7BafKyH1FpFzoiF8exoio02pZhMySPMCzQ5efzL
         vn5I9ZzDiGi4nXwzrSl6bhZ1CYSsg3eFxUFUvoKontnOJHdOpwxlF/F4Bo46R+QuRxVm
         GwCQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0VFh8AEMITjeHjpMbZADoCp4Ijbvq4P9W7ZoLOATgT9oEUgvZ5RRb7HwhqeUuYmW7rcs=@vger.kernel.org
X-Gm-Message-State: AFuF++ll3YLjbMZ+CyhmAfzIKtg1ZgN8OT+yzLMbNFt+XiEKfvYb0KrV
	4KueLHc1pYeAHVurSJPM8mZ6bmzgb29IJ0Ka01e/DcWobtCkAQXefWoK
X-Gm-Gg: AYBFou39bOm+Ue9+SSMuUUBqZaab2AuYanewA2I19dM59B6Stb8ciy7NpQklOiVBemr
	fpG05VjQG1+oChMRUlO+E/VWBGvGjWlVyt20tp+gMcZUtZgQDRoeEisK1sehCpnWdbhBhdYwGwi
	TXU+wNrCOavsIahnhUvCjJSq1u6+ot1hVPQ8vNCWeILFS5rNTW6Jc3pLlYE+B6etMi/5U+aViYl
	qIKFaFqRUoXVhuIrlHJW0AY/iPodnyawLeIa7LvKeqbn8fKrXMgdU3Ygfb5nKFe7dT2aJFd15CB
	fPTxXdLXcM/o3JWp5sQrbtSomhjly448cpC4fjZf77p8+fsPkYvHa7LlJYGEK2BWSdhYEQdSLxp
	IVsmr54NwIFMeDtbYL54A96vPbqWFtoxiWoDYuHBxufXOS3YkJjkrYM0ZH7AgR4keOmft862y+F
	rzD4jVD6DkR/7rmiWShKGyT8G62C0g+2dpS8aXed9iydSZssaNdlHxLO7TP53d24OX+LoqbS70Z
	vCQ09aI7PBnIvGZOHh9J+N/BsAghUuX7qaKx7OioFoxrXm6q4bnQmYy1vr6v7z4qB2dmar4qOap
	WPohoNtDtrRIFQ==
X-Received: by 2002:a05:6300:68ca:20b0:3dd:a197:edfa with SMTP id adf61e73a8af0-3dda197f7e9mr8111865637.73.1790041981393;
        Mon, 21 Sep 2026 18:53:01 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a30002sm67370a12.13.2026.09.21.18.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 18:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 01:53:00 +0000
Message-Id: <DLLGX9F9UG4Q.2YJWNSO4FXT1P@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>,
 <rcu@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Harry Yoo (Oracle)"
 <harry@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921191407.1742386-1-puranjay@kernel.org>
 <20260921191407.1742386-2-puranjay@kernel.org>
In-Reply-To: <20260921191407.1742386-2-puranjay@kernel.org>

On Mon Sep 21, 2026 at 7:14 PM UTC, Puranjay Mohan wrote:
> BPF programs that manage their own objects have no way to run their own
> logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> free, but returning an index to an allocator or unpinning a resource
> once readers are done has no equivalent.  sched_ext's BPF library works
> around this today by pushing freed nodes onto a list and having a
> userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> BPF program to reclaim them.
>
> Add:
>
> 	int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> 			 int (*callback)(struct bpf_map *map, void *key,
> 					 void *value));
>
> @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> callback runs as callback(map, key, value) for the element it lives in
> and needs no cookie.  A head can only be armed once, which bounds
> outstanding work by the number of elements.
>
> struct bpf_rcu_head holds the callback state inline rather than a
> pointer to it, as bpf_timer, bpf_wq and bpf_task_work do, because there
> is nothing to cancel and so nothing that has to outlive the map value.
> That avoids an allocation and a state machine on the arming path at the
> cost of 64 bytes per element, 48 of which are used today.  Embedding
> struct rcu_head ties part of a uapi struct to a definition outside of
> BPF, which is acceptable here only because it is two pointers, a
> callback and its argument, with no room to grow.
>
> An RCU callback cannot be cancelled, so everything it touches has to
> stay alive until it runs:
>
>   - The callback is the program's text, so arming takes a program
>     reference as bpf_timer, bpf_wq and bpf_task_work do, dropped once
>     the callback returns.  bpf_prog_inc_not_zero() also fails the arm
>     with -EBADF once the program is dying.
>
>   - The map is held by that reference through used_maps.  An inner map
>     is not, so bpf_rcu_head is rejected in one.
>
>   - The field is only accepted in BPF_MAP_TYPE_ARRAY, whose elements
>     are never freed individually.  A hash element can be deleted and
>     recycled while a callback is queued on it.
>
>   - The head is disarmed before the callback runs so it can be armed
>     again from there, which takes a new program reference before the
>     running callback drops its own.  Arming therefore fails with -EPERM
>     once the map is held by neither a process nor bpffs, which is what
>     bpf_timer and bpf_wq do at init time; bpf_task_work uses -EBUSY and
>     additionally cancels, which is not possible here.
>
> bpf_iter hands a program a writable pointer to the live element, which
> would let it overwrite a queued head, so bpf_iter_attach_map() rejects
> maps carrying one.
>
> The callback is verified non-sleepable even when the caller is
> sleepable, and RCU invokes it with BH disabled.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/bpf.h            | 10 +++++
>  include/uapi/linux/bpf.h       |  4 ++
>  kernel/bpf/btf.c               |  7 +++
>  kernel/bpf/helpers.c           | 75 +++++++++++++++++++++++++++++++
>  kernel/bpf/map_in_map.c        |  4 ++
>  kernel/bpf/map_iter.c          |  6 +++
>  kernel/bpf/syscall.c           | 11 ++++-
>  kernel/bpf/verifier.c          | 81 +++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h |  4 ++
>  9 files changed, 199 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index fd22db8bc6c50..e7c5e203edddb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -215,6 +215,7 @@ enum btf_field_type {
>  	BPF_UPTR       =3D (1 << 11),
>  	BPF_RES_SPIN_LOCK =3D (1 << 12),
>  	BPF_TASK_WORK  =3D (1 << 13),
> +	BPF_RCU_HEAD   =3D (1 << 14),
>  };
> =20
>  enum bpf_cgroup_storage_type {
> @@ -269,6 +270,7 @@ struct btf_record {
>  	int wq_off;
>  	int refcount_off;
>  	int task_work_off;
> +	int rcu_head_off;
>  	struct btf_field fields[];
>  };
> =20
> @@ -374,6 +376,8 @@ static inline const char *btf_field_type_name(enum bt=
f_field_type type)
>  		return "bpf_refcount";
>  	case BPF_TASK_WORK:
>  		return "bpf_task_work";
> +	case BPF_RCU_HEAD:
> +		return "bpf_rcu_head";
>  	default:
>  		WARN_ON_ONCE(1);
>  		return "unknown";
> @@ -414,6 +418,8 @@ static inline u32 btf_field_type_size(enum btf_field_=
type type)
>  		return sizeof(struct bpf_refcount);
>  	case BPF_TASK_WORK:
>  		return sizeof(struct bpf_task_work);
> +	case BPF_RCU_HEAD:
> +		return sizeof(struct bpf_rcu_head);
>  	default:
>  		WARN_ON_ONCE(1);
>  		return 0;
> @@ -448,6 +454,8 @@ static inline u32 btf_field_type_align(enum btf_field=
_type type)
>  		return __alignof__(struct bpf_refcount);
>  	case BPF_TASK_WORK:
>  		return __alignof__(struct bpf_task_work);
> +	case BPF_RCU_HEAD:
> +		return __alignof__(struct bpf_rcu_head);
>  	default:
>  		WARN_ON_ONCE(1);
>  		return 0;
> @@ -480,6 +488,7 @@ static inline void bpf_obj_init_field(const struct bt=
f_field *field, void *addr)
>  	case BPF_KPTR_PERCPU:
>  	case BPF_UPTR:
>  	case BPF_TASK_WORK:
> +	case BPF_RCU_HEAD:
>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
> @@ -925,6 +934,7 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_RB_NODE,	/* pointer to bpf_rb_node */
>  	ARG_PTR_TO_WORKQUEUE,	/* pointer to bpf_wq */
>  	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
> +	ARG_PTR_TO_RCU_HEAD,	/* pointer to bpf_rcu_head */
>  	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
>  	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
>  	ARG_PTR_TO_CTX_OUT,	/* hook output argument passed through from ctx */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6330b7d745c57..eafeba23f5da7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7611,6 +7611,10 @@ struct bpf_task_work {
>  	__u64 __opaque;
>  } __attribute__((aligned(8)));
> =20
> +struct bpf_rcu_head {
> +	__u64 __opaque[8];
> +} __attribute__((aligned(8)));
> +
>  struct bpf_wq {
>  	__u64 __opaque[2];
>  } __attribute__((aligned(8)));
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 314ecb0e593b0..4a1fa4fbdf4e8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3696,6 +3696,7 @@ static int btf_get_field_type(const struct btf *btf=
, const struct btf_type *var_
>  		{ BPF_TIMER, "bpf_timer", true },
>  		{ BPF_WORKQUEUE, "bpf_wq", true },
>  		{ BPF_TASK_WORK, "bpf_task_work", true },
> +		{ BPF_RCU_HEAD, "bpf_rcu_head", true },
>  		{ BPF_LIST_HEAD, "bpf_list_head", false },
>  		{ BPF_LIST_NODE, "bpf_list_node", false },
>  		{ BPF_RB_ROOT, "bpf_rb_root", false },
> @@ -3881,6 +3882,7 @@ static int btf_find_field_one(const struct btf *btf=
,
>  	case BPF_RB_NODE:
>  	case BPF_REFCOUNT:
>  	case BPF_TASK_WORK:
> +	case BPF_RCU_HEAD:
>  		ret =3D btf_find_struct(btf, var_type, off, sz, field_type,
>  				      info_cnt ? &info[0] : &tmp);
>  		if (ret < 0)
> @@ -4176,6 +4178,7 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
>  	rec->wq_off =3D -EINVAL;
>  	rec->refcount_off =3D -EINVAL;
>  	rec->task_work_off =3D -EINVAL;
> +	rec->rcu_head_off =3D -EINVAL;
>  	for (i =3D 0; i < cnt; i++) {
>  		field_type_size =3D btf_field_type_size(info_arr[i].type);
>  		if (info_arr[i].off + field_type_size > value_size) {
> @@ -4219,6 +4222,10 @@ struct btf_record *btf_parse_fields(const struct b=
tf *btf, const struct btf_type
>  			WARN_ON_ONCE(rec->task_work_off >=3D 0);
>  			rec->task_work_off =3D rec->fields[i].offset;
>  			break;
> +		case BPF_RCU_HEAD:
> +			WARN_ON_ONCE(rec->rcu_head_off >=3D 0);
> +			rec->rcu_head_off =3D rec->fields[i].offset;
> +			break;
>  		case BPF_REFCOUNT:
>  			WARN_ON_ONCE(rec->refcount_off >=3D 0);
>  			/* Cache offset for faster lookup at runtime */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 501c7ce35cba9..8a01dd4058a03 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4805,6 +4805,80 @@ __bpf_kfunc int bpf_task_work_schedule_resume(stru=
ct task_struct *task, struct b
>  	return bpf_task_work_schedule(task, tw, map__const_map, callback, aux, =
TWA_RESUME);
>  }
> =20
> +typedef int (*bpf_rcu_callback_t)(struct bpf_map *map, void *key, void *=
value);
> +
> +/* Actual type for struct bpf_rcu_head */
> +struct bpf_rcu_head_kern {
> +	struct rcu_head rcu;
> +	bpf_callback_t callback_fn;
> +	struct bpf_map *map;
> +	struct bpf_prog *prog;
> +	u32 armed;
> +} __aligned(8);
> +
> +static void bpf_rcu_run_callback(struct rcu_head *rcu)
> +{
> +	struct bpf_rcu_head_kern *rh =3D container_of(rcu, struct bpf_rcu_head_=
kern, rcu);
> +	bpf_callback_t callback_fn =3D rh->callback_fn;
> +	struct bpf_prog *prog =3D rh->prog;
> +	struct bpf_map *map =3D rh->map;
> +	void *value, *key;
> +	u32 idx;
> +
> +	value =3D (void *)rh - map->record->rcu_head_off;
> +	key =3D map_key_from_value(map, value, &idx);
> +
> +	/* Pairs with the arming cmpxchg(): rh may be re-armed as soon as this =
store lands. */
> +	smp_store_release(&rh->armed, 0);
> +
> +	rcu_read_lock_dont_migrate();
> +	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
> +	rcu_read_unlock_migrate();
> +
> +	bpf_prog_put(prog);
> +}
> +
> +/**
> + * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
> + * @rh: struct bpf_rcu_head in a BPF map value
> + * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the value=
s
> + * @callback: BPF subprogram, invoked as callback(map, key, value) for t=
he value holding @rh
> + * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
> + *
> + * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by=
 neither a process
> + * nor bpffs, or -EBADF if the calling program is going away.
> + */
> +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_m=
ap,
> +			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
> +{
> +	struct bpf_rcu_head_kern *rhk =3D (void *)rh;
> +	struct bpf_map *map =3D map__const_map;
> +	struct bpf_prog *prog;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf_rcu_h=
ead));
> +	BUILD_BUG_ON(__alignof__(struct bpf_rcu_head_kern) !=3D __alignof__(str=
uct bpf_rcu_head));
> +	BTF_TYPE_EMIT(struct bpf_rcu_head);
> +
> +	/* A queued callback cannot be cancelled, so a self-rearming one would =
pin prog and map. */
> +	if (!atomic64_read(&map->usercnt))
> +		return -EPERM;
> +
> +	if (cmpxchg(&rhk->armed, 0, 1))
> +		return -EBUSY;
> +
> +	prog =3D bpf_prog_inc_not_zero(aux->prog);
> +	if (IS_ERR(prog)) {
> +		WRITE_ONCE(rhk->armed, 0);
> +		return -EBADF;
> +	}

can we drop prog_inc and remove prog pointer from rhk ?
with something like if (prog->has_call_rcu) rcu_barrier() during prog unloa=
d?

