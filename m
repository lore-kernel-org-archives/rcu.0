Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AEA59B68E
	for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584093; cv=none; b=m5QWE3wF2N7WwYoCRdhTDkjXQNejU+CPR4nGmJijdZjtGEPrb+tQKAgAwuPNUNSZWLZTt07Z48HeR4EC4sFr/OcZ4QwAg56jvT0hmGAcV9KnlS5SxMn3MZviAPOrYnTism9BYRbn83w1surZL+arjPcY1WsPG9alZSEOVSKXvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584093; c=relaxed/simple;
	bh=1iG/J3MYkA2b7GryaLplRRHM+sufQtFheWb3ctcGd9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8HPqb0dCYpgb6/u8dl6kvXJWSEjtYM5l5HmCAifg2mUoOIblBgHLRUbbBUy/afyN/f/jwVyX7m3BjktZkgkjRS87w9dah04mfvdcw99Kwm7DyctEmwixWadrG057paPQM1X/WOy0QzCzAN0Y3gUmP9yW98hxRU4a5veM8WIE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO8JpN7j; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO8JpN7j"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f88so41195f8f.2
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789584064; x=1790188864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1t1Wkd/RSEu4KIbgKRfviha16n4WuSqIw2Q+P3lzGw=;
        b=jO8JpN7j6v8hlmo9s5tj6XVIwEh2qJNrVRvDExdsAdebbZ9VfVHu1bsS2V0YZ/qHuq
         FV+Q2nLrMhpfNJy6DHcqjWLofHds6JKCh0UNeXcS2KQJMUj1eBu9Hw8Wn4C3FOuZ6qnY
         QgIrN84lJkiQ71+HePG4gQ+LISAg3S4RByHX6kihxoPPeqg2RWy5e1PHjEd38j4LbHP3
         uVw5iQD9kJ+Wc1d/rcmUkUSd+VD9Mr6fWOAWPhnI9e1W+u5HeJEpDzlC51zblJGmyQX2
         ytWXWwDAZM4D122fbnJqyJd7hICKf8x+6r2vRqZ0CCBIOYyDpifHlZMnAK4cde9p0TSf
         Yx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789584064; x=1790188864;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1t1Wkd/RSEu4KIbgKRfviha16n4WuSqIw2Q+P3lzGw=;
        b=GFPLdWhq1GjBOJbY7SubYcQcCdp/btBAJCJTbMWvj0TQc16gc3mvgbH0gF9dHQqOhs
         7AW12aogYAGpPMf63Vi7dIhUDiKHFwjExPoSRFmSB8XgApFccCZliKw44iZ0itV8o92w
         OStWQ6Hwgl0TCiNjDO2QcssPRz6G1ZtPCIRsk5jBWhxBFsHftdW76tPgClo4PxYQNyLw
         vkrkXJBybXol7fW5ABRfBv3OLm83KyCWVJTffWPVcW/cCZDLrGf2sIyZ62c18WMx01o9
         8NiPcxEj/Fq4ExCUfNgPxlrarz2DCingwEW+aX54RQzqqrDjdXQ7dWNmd1FyubGlt+JP
         /cHg==
X-Forwarded-Encrypted: i=1; AKwUvBy1U/aVJUfrNIpARlPVLc0XG2VewZPXcj2YsgfK0g/wMJAD2PnvNVojtNpePd0p79MNdEQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lh/SzKJzuRhW6dWwtl4nSePZ1OFOpHU4ZS4uRBcqBlgzWHanHF
	RSAEGOY/lb6s/CZez8jiBHKMg3kCusOjMwoxmwDKicpF/nRu1VkhFsXH
X-Gm-Gg: AYBFou0h6aJ6hKozlWH40qzv49c2NZ8LCh3X6mFC5qZlItINCnnjC2JY9qqhnUxpPSV
	kBv9xTNH/DikHvpJSAgL3d0cpTtMpxdrQkMQF3QKdvZ210LpT19oncemhZhthvyOUII2QVeMDsw
	2XUFRR5lPRhBHM2om6oDJ05St3480WSf/4gdjxmP/OijHYR/VqrMtuDIG/Mbz2TPUgi6yeyC/HE
	uO1ao+PkzOrDNLxGeDygiMCEPzjIjzNger2TBJz4diWRiW/4B3ZScWVD/dXV3bytW84siCczGqX
	/yzilNGABCKCYZ8SWdRTWW/iK+RrpSkyubGzO+U9P9OpJzRWraWyr3+YvYCfvVVLARbxHwknJnH
	H19CgqA+hRQL3Sm47xsAVK/YGcGIQ3QISzupV0v5GXfoE6Ofj9CTWHgIeH1XD/EYTxp/zxxrIsp
	wOLtyNK6oCM74KWA6uOA5ppGttgwxeqVdBv4jgEqgSyw8eY7Zo+tnSON9mxcvmrPSsP7Ib61gKr
	yWmO3Kv3u3tNpEfAi7gxwfsXgH0ZwZWqVzQ
X-Received: by 2002:a05:6000:490d:b0:487:342:d147 with SMTP id ffacd0b85a97d-4870d16988fmr4819954f8f.39.1789584063771;
        Wed, 16 Sep 2026 11:41:03 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4a5e:f479:a4b6:a0f2? ([2620:10d:c092:500::7:90fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27a36sm8469134f8f.17.2026.09.16.11.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 11:41:03 -0700 (PDT)
Message-ID: <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com>
Date: Wed, 16 Sep 2026 19:41:02 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add bpf_call_rcu() kfunc
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
 rcu@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 "Harry Yoo (Oracle)" <harry@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20260915154248.3612028-1-puranjay@kernel.org>
 <20260915154248.3612028-2-puranjay@kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260915154248.3612028-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 4:42 PM, Puranjay Mohan wrote:
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

I tried to fully embed structure back when implementing bpf_task_work,
Alexei rejected that approach, because some of the structures (irq_work) I used
are not in our control and might change. I think this applies here: `struct rcu_head rcu`.

Link: https://lore.kernel.org/bpf/CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6uNGZ3OBQh4V5Zt=WnQ@mail.gmail.com/
> That avoids an allocation and a state machine on the arming path at the
> cost of 64 bytes per element, 48 of which are used today.
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
> index 2a5fa346aadaa..22d0743f8fb5e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -214,6 +214,7 @@ enum btf_field_type {
>  	BPF_UPTR       = (1 << 11),
>  	BPF_RES_SPIN_LOCK = (1 << 12),
>  	BPF_TASK_WORK  = (1 << 13),
> +	BPF_RCU_HEAD   = (1 << 14),
>  };
>  
>  enum bpf_cgroup_storage_type {
> @@ -268,6 +269,7 @@ struct btf_record {
>  	int wq_off;
>  	int refcount_off;
>  	int task_work_off;
> +	int rcu_head_off;
>  	struct btf_field fields[];
>  };
>  
> @@ -373,6 +375,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
>  		return "bpf_refcount";
>  	case BPF_TASK_WORK:
>  		return "bpf_task_work";
> +	case BPF_RCU_HEAD:
> +		return "bpf_rcu_head";
>  	default:
>  		WARN_ON_ONCE(1);
>  		return "unknown";
> @@ -413,6 +417,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
>  		return sizeof(struct bpf_refcount);
>  	case BPF_TASK_WORK:
>  		return sizeof(struct bpf_task_work);
> +	case BPF_RCU_HEAD:
> +		return sizeof(struct bpf_rcu_head);
>  	default:
>  		WARN_ON_ONCE(1);
>  		return 0;
> @@ -447,6 +453,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
>  		return __alignof__(struct bpf_refcount);
>  	case BPF_TASK_WORK:
>  		return __alignof__(struct bpf_task_work);
> +	case BPF_RCU_HEAD:
> +		return __alignof__(struct bpf_rcu_head);
>  	default:
>  		WARN_ON_ONCE(1);
>  		return 0;
> @@ -479,6 +487,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
>  	case BPF_KPTR_PERCPU:
>  	case BPF_UPTR:
>  	case BPF_TASK_WORK:
> +	case BPF_RCU_HEAD:
>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
> @@ -921,6 +930,7 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_RB_NODE,	/* pointer to bpf_rb_node */
>  	ARG_PTR_TO_WORKQUEUE,	/* pointer to bpf_wq */
>  	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
> +	ARG_PTR_TO_RCU_HEAD,	/* pointer to bpf_rcu_head */
>  	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
>  	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
>  	ARG_PTR_TO_PROG_AUX,	/* pointer to the caller's bpf_prog_aux */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 732b35cc08d1c..8871217a9d47f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7600,6 +7600,10 @@ struct bpf_task_work {
>  	__u64 __opaque;
>  } __attribute__((aligned(8)));
>  
> +struct bpf_rcu_head {
> +	__u64 __opaque[8];
> +} __attribute__((aligned(8)));
> +
>  struct bpf_wq {
>  	__u64 __opaque[2];
>  } __attribute__((aligned(8)));
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7daf4c286c9b2..a48795cc9f1a7 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3695,6 +3695,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
>  		{ BPF_TIMER, "bpf_timer", true },
>  		{ BPF_WORKQUEUE, "bpf_wq", true },
>  		{ BPF_TASK_WORK, "bpf_task_work", true },
> +		{ BPF_RCU_HEAD, "bpf_rcu_head", true },
>  		{ BPF_LIST_HEAD, "bpf_list_head", false },
>  		{ BPF_LIST_NODE, "bpf_list_node", false },
>  		{ BPF_RB_ROOT, "bpf_rb_root", false },
> @@ -3880,6 +3881,7 @@ static int btf_find_field_one(const struct btf *btf,
>  	case BPF_RB_NODE:
>  	case BPF_REFCOUNT:
>  	case BPF_TASK_WORK:
> +	case BPF_RCU_HEAD:
>  		ret = btf_find_struct(btf, var_type, off, sz, field_type,
>  				      info_cnt ? &info[0] : &tmp);
>  		if (ret < 0)
> @@ -4175,6 +4177,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>  	rec->wq_off = -EINVAL;
>  	rec->refcount_off = -EINVAL;
>  	rec->task_work_off = -EINVAL;
> +	rec->rcu_head_off = -EINVAL;
>  	for (i = 0; i < cnt; i++) {
>  		field_type_size = btf_field_type_size(info_arr[i].type);
>  		if (info_arr[i].off + field_type_size > value_size) {
> @@ -4218,6 +4221,10 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>  			WARN_ON_ONCE(rec->task_work_off >= 0);
>  			rec->task_work_off = rec->fields[i].offset;
>  			break;
> +		case BPF_RCU_HEAD:
> +			WARN_ON_ONCE(rec->rcu_head_off >= 0);
> +			rec->rcu_head_off = rec->fields[i].offset;
> +			break;
>  		case BPF_REFCOUNT:
>  			WARN_ON_ONCE(rec->refcount_off >= 0);
>  			/* Cache offset for faster lookup at runtime */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 051b6654e57c6..6debb92fc8740 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4677,6 +4677,80 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
>  	return bpf_task_work_schedule(task, tw, map__const_map, callback, aux, TWA_RESUME);
>  }
>  
> +typedef int (*bpf_rcu_callback_t)(struct bpf_map *map, void *key, void *value);
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
> +	struct bpf_rcu_head_kern *rh = container_of(rcu, struct bpf_rcu_head_kern, rcu);
> +	bpf_callback_t callback_fn = rh->callback_fn;
> +	struct bpf_prog *prog = rh->prog;
> +	struct bpf_map *map = rh->map;
> +	void *value, *key;
> +	u32 idx;
> +
> +	value = (void *)rh - map->record->rcu_head_off;
> +	key = map_key_from_value(map, value, &idx);
> +
> +	/* Pairs with the arming cmpxchg(): rh may be re-armed as soon as this store lands. */
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
> + * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the values
> + * @callback: BPF subprogram, invoked as callback(map, key, value) for the value holding @rh
> + * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
> + *
> + * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
> + * nor bpffs, or -EBADF if the calling program is going away.
> + */
> +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
> +			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
> +{
> +	struct bpf_rcu_head_kern *rhk = (void *)rh;
> +	struct bpf_map *map = map__const_map;
> +	struct bpf_prog *prog;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf_rcu_head));
> +	BUILD_BUG_ON(__alignof__(struct bpf_rcu_head_kern) != __alignof__(struct bpf_rcu_head));
> +	BTF_TYPE_EMIT(struct bpf_rcu_head);
> +
> +	/* A queued callback cannot be cancelled, so a self-rearming one would pin prog and map. */
> +	if (!atomic64_read(&map->usercnt))
> +		return -EPERM;
> +
> +	if (cmpxchg(&rhk->armed, 0, 1))
> +		return -EBUSY;
> +
> +	prog = bpf_prog_inc_not_zero(aux->prog);
> +	if (IS_ERR(prog)) {
> +		WRITE_ONCE(rhk->armed, 0);
> +		return -EBADF;
> +	}
> +
> +	rhk->callback_fn = (bpf_callback_t)(void *)callback;
> +	rhk->map = map;
> +	rhk->prog = prog;
> +	call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> +	return 0;
> +}
> +
>  static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
>  			    struct bpf_dynptr_kern *ptr)
>  {
> @@ -4970,6 +5044,7 @@ BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
>  BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, bpf_call_rcu, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_file)
>  BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_timer_cancel_async)
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index d2cbab4bdf644..5ee8aae7435ba 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -25,6 +25,10 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>  	if (!inner_map->ops->map_meta_equal)
>  		return ERR_PTR(-ENOTSUPP);
>  
> +	/* An inner map has no used_maps reference to hold it under a queued callback. */
> +	if (btf_record_has_field(inner_map->record, BPF_RCU_HEAD))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	inner_map_meta_size = sizeof(*inner_map_meta);
>  	/* In some cases verifier needs to access beyond just base map. */
>  	if (inner_map->ops == &array_map_ops || inner_map->ops == &percpu_array_map_ops)
> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index c19b360bad9ea..2077d46d167c7 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -117,6 +117,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
>  		goto put_map;
>  	}
>  
> +	/* The value ctx arg is writable and aliases the live element. */
> +	if (btf_record_has_field(map->record, BPF_RCU_HEAD)) {
> +		err = -EOPNOTSUPP;
> +		goto put_map;
> +	}
> +
>  	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
>  	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>  	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index def57bddb0924..df9a54817f783 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -687,6 +687,7 @@ void btf_record_free(struct btf_record *rec)
>  		case BPF_REFCOUNT:
>  		case BPF_WORKQUEUE:
>  		case BPF_TASK_WORK:
> +		case BPF_RCU_HEAD:
>  			/* Nothing to release */
>  			break;
>  		default:
> @@ -741,6 +742,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
>  		case BPF_REFCOUNT:
>  		case BPF_WORKQUEUE:
>  		case BPF_TASK_WORK:
> +		case BPF_RCU_HEAD:
>  			/* Nothing to acquire */
>  			break;
>  		default:
> @@ -874,6 +876,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  		case BPF_LIST_NODE:
>  		case BPF_RB_NODE:
>  		case BPF_REFCOUNT:
> +		case BPF_RCU_HEAD:
>  			break;
>  		default:
>  			WARN_ON_ONCE(1);
> @@ -1277,7 +1280,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>  	map->record = btf_parse_fields(btf, value_type,
>  				       BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
>  				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR |
> -				       BPF_TASK_WORK,
> +				       BPF_TASK_WORK | BPF_RCU_HEAD,
>  				       map->value_size);
>  	if (!IS_ERR_OR_NULL(map->record)) {
>  		int i;
> @@ -1319,6 +1322,12 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>  					goto free_map_tab;
>  				}
>  				break;
> +			case BPF_RCU_HEAD:
> +				if (map->map_type != BPF_MAP_TYPE_ARRAY) {
> +					ret = -EOPNOTSUPP;
> +					goto free_map_tab;
> +				}
> +				break;
>  			case BPF_KPTR_UNREF:
>  			case BPF_KPTR_REF:
>  			case BPF_KPTR_PERCPU:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..7051e19bb78b3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -529,6 +529,7 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
>  
>  static bool is_sync_callback_calling_kfunc(u32 btf_id);
>  static bool is_async_callback_calling_kfunc(u32 btf_id);
> +static bool is_call_rcu_kfunc(u32 btf_id);
>  static bool is_callback_calling_kfunc(u32 btf_id);
>  
>  static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
> @@ -571,6 +572,10 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
>  	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_timer_set_callback)
>  		return false;
>  
> +	/* bpf_call_rcu callbacks are never sleepable. */
> +	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 && is_call_rcu_kfunc(insn->imm))
> +		return false;
> +
>  	/* bpf_wq and bpf_task_work callbacks are always sleepable. */
>  	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
>  	    (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
> @@ -7572,6 +7577,9 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, struct bpf_reg_
>  	case BPF_TASK_WORK:
>  		field_off = map->record->task_work_off;
>  		break;
> +	case BPF_RCU_HEAD:
> +		field_off = map->record->rcu_head_off;
> +		break;
>  	case BPF_WORKQUEUE:
>  		field_off = map->record->wq_off;
>  		break;
> @@ -8427,6 +8435,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_RES_SPIN_LOCK]	= &map_value_or_alloc_obj_types,
>  	[ARG_PTR_TO_WORKQUEUE]		= &map_value_types,
>  	[ARG_PTR_TO_TASK_WORK]		= &map_value_types,
> +	[ARG_PTR_TO_RCU_HEAD]		= &map_value_types,
>  	[ARG_PTR_TO_IRQ_FLAG]		= &stack_ptr_types,
>  	[ARG_PTR_TO_ARENA]		= &arena_types,
>  };
> @@ -8872,6 +8881,8 @@ static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_stat
>  			obj_name = "timer";
>  		else if (rec->task_work_off >= 0)
>  			obj_name = "bpf_task_work";
> +		else if (rec->rcu_head_off >= 0)
> +			obj_name = "bpf_rcu_head";
>  
>  		verbose(env, "%s pointer in %s map_uid=%d ",
>  			obj_name, reg_arg_name(env, obj_argno), meta->map.uid);
> @@ -9416,6 +9427,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
>  		if (err < 0)
>  			return err;
>  		break;
> +	case ARG_PTR_TO_RCU_HEAD:
> +		err = check_map_field_pointer(env, reg, argno, BPF_RCU_HEAD, &meta->map);
> +		if (err < 0)
> +			return err;
> +		break;
>  	case ARG_PTR_TO_IRQ_FLAG:
>  		err = process_irq_flag(env, reg, argno, meta);
>  		if (err < 0)
> @@ -10909,6 +10925,40 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +static int set_rcu_callback_state(struct bpf_verifier_env *env,
> +				  struct bpf_func_state *caller,
> +				  struct bpf_func_state *callee,
> +				  int insn_idx)
> +{
> +	struct bpf_map *map_ptr = caller->regs[BPF_REG_2].map_ptr;
> +	u32 map_uid = caller->regs[BPF_REG_2].map_uid;
> +
> +	/*
> +	 * callback_fn(struct bpf_map *map, void *key, void *value);
> +	 */
> +	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> +	callee->regs[BPF_REG_1].map_ptr = map_ptr;
> +	callee->regs[BPF_REG_1].map_uid = map_uid;
> +
> +	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
> +	callee->regs[BPF_REG_2].map_ptr = map_ptr;
> +	callee->regs[BPF_REG_2].map_uid = map_uid;
> +
> +	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
> +	callee->regs[BPF_REG_3].map_ptr = map_ptr;
> +	callee->regs[BPF_REG_3].map_uid = map_uid;
> +
> +	/* unused */
> +	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> +	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
> +	callee->in_async_callback_fn = true;
> +	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
> +	return 0;
> +}
> +
>  static bool is_rbtree_lock_required_kfunc(u32 btf_id);
>  
>  static void account_processed_insn(struct bpf_verifier_env *env)
> @@ -12172,7 +12222,8 @@ enum {
>  	KF_ARG_RES_SPIN_LOCK_ID,
>  	KF_ARG_TASK_WORK_ID,
>  	KF_ARG_PROG_AUX_ID,
> -	KF_ARG_TIMER_ID
> +	KF_ARG_TIMER_ID,
> +	KF_ARG_RCU_HEAD_ID
>  };
>  
>  BTF_ID_LIST(kf_arg_btf_ids)
> @@ -12186,6 +12237,7 @@ BTF_ID(struct, bpf_res_spin_lock)
>  BTF_ID(struct, bpf_task_work)
>  BTF_ID(struct, bpf_prog_aux)
>  BTF_ID(struct, bpf_timer)
> +BTF_ID(struct, bpf_rcu_head)
>  
>  static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
>  				    const struct btf_param *arg, int type)
> @@ -12244,6 +12296,11 @@ static bool is_kfunc_arg_task_work(const struct btf *btf, const struct btf_param
>  	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TASK_WORK_ID);
>  }
>  
> +static bool is_kfunc_arg_rcu_head(const struct btf *btf, const struct btf_param *arg)
> +{
> +	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RCU_HEAD_ID);
> +}
> +
>  static bool is_kfunc_arg_res_spin_lock(const struct btf *btf, const struct btf_param *arg)
>  {
>  	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RES_SPIN_LOCK_ID);
> @@ -12526,6 +12583,7 @@ enum special_kfunc_type {
>  	KF___bpf_trap,
>  	KF_bpf_task_work_schedule_signal,
>  	KF_bpf_task_work_schedule_resume,
> +	KF_bpf_call_rcu,
>  	KF_bpf_arena_alloc_pages,
>  	KF_bpf_arena_free_pages,
>  	KF_bpf_arena_reserve_pages,
> @@ -12619,6 +12677,7 @@ BTF_ID(func, bpf_dynptr_file_discard)
>  BTF_ID(func, __bpf_trap)
>  BTF_ID(func, bpf_task_work_schedule_signal)
>  BTF_ID(func, bpf_task_work_schedule_resume)
> +BTF_ID(func, bpf_call_rcu)
>  BTF_ID(func, bpf_arena_alloc_pages)
>  BTF_ID(func, bpf_arena_free_pages)
>  BTF_ID(func, bpf_arena_reserve_pages)
> @@ -12690,6 +12749,11 @@ static bool is_bpf_rbtree_add_kfunc(u32 func_id)
>  	       func_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
>  }
>  
> +static bool is_call_rcu_kfunc(u32 func_id)
> +{
> +	return func_id == special_kfunc_list[KF_bpf_call_rcu];
> +}
> +
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {
>  	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
> @@ -12896,6 +12960,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  		arg_type = ARG_PTR_TO_TIMER;
>  	else if (is_kfunc_arg_task_work(meta->btf, &args[arg]))
>  		arg_type = ARG_PTR_TO_TASK_WORK;
> +	else if (is_kfunc_arg_rcu_head(meta->btf, &args[arg]))
> +		arg_type = ARG_PTR_TO_RCU_HEAD;
>  	else if (is_kfunc_arg_irq_flag(meta->btf, &args[arg]))
>  		arg_type = ARG_PTR_TO_IRQ_FLAG;
>  	else if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
> @@ -13381,7 +13447,8 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
>  static bool is_async_callback_calling_kfunc(u32 btf_id)
>  {
>  	return is_bpf_wq_set_callback_kfunc(btf_id) ||
> -	       is_task_work_add_kfunc(btf_id);
> +	       is_task_work_add_kfunc(btf_id) ||
> +	       is_call_rcu_kfunc(btf_id);
>  }
>  
>  bool bpf_is_throw_kfunc(struct bpf_insn *insn)
> @@ -14185,6 +14252,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		}
>  	}
>  
> +	if (is_call_rcu_kfunc(meta.func_id)) {
> +		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
> +					 set_rcu_callback_state);
> +		if (err) {
> +			verbose(env, "kfunc %s#%d failed callback verification\n",
> +				func_name, meta.func_id);
> +			return err;
> +		}
> +	}
> +
>  	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
>  	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 732b35cc08d1c..8871217a9d47f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7600,6 +7600,10 @@ struct bpf_task_work {
>  	__u64 __opaque;
>  } __attribute__((aligned(8)));
>  
> +struct bpf_rcu_head {
> +	__u64 __opaque[8];
> +} __attribute__((aligned(8)));
> +
>  struct bpf_wq {
>  	__u64 __opaque[2];
>  } __attribute__((aligned(8)));

