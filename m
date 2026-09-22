Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8240549387
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086639; cv=pass; b=VCC4pXfNtv32EYqvLeYACxwpkV/2ktjk9wWAjkC5xm85UX9W6QfPxPpmi1kNMItOSOo3aqPY/6bl9cUUk3lH8/eSlPZiroYBPsCp2CxN9rdAtVq0UDUk+raPUpX/HZVaHjQ08w3XvUBX8o/H2g2D0y71BrHIujKY/8M0U34hE0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086639; c=relaxed/simple;
	bh=0aBw0lWU0qoJvUAdJ3f5WxjveXVL8axhEFzAI1osMI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qw3BGI2ow9XW/9ZrBdFF+9GbBzWGrRjQXc3QflpwT3YEV4SjT949Cl8Qlv7zFN+ihGt8FxSmNOwmZ9pqEU6JRytFLelpB0S3TEknZywuCRU6ROuo3lv3S4CAkt5mv7vWL7YIf6QRbt8R06fJBgnLYEbHNYvS/I3lUu3P7etVL0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhPlUCmn; arc=pass smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhPlUCmn"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c254fa663bfso642591066b.1
        for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 07:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790086636; cv=none;
        d=google.com; s=arc-20260327;
        b=Y4giLYQRjgv4fLxsWQAQQHr51KCrkDS96elfZc44OmTs5j0Enx2O/jR9B6f8/7Tq7y
         gahjO+pC3p2iXypLvnrpyJvOX1oMo5PfKvuHRvUX34/H4gfhdQPS+EpwA5n5Gnaa3TxS
         COhq6bu0pthyglIXeFQ4knETx1Na2N73sHQAqUHl4ytK1Ufia6JHA4ErN6PNydR9YLap
         CRr+aInnKCqMB0gwg+ipymQpPzkXBZkuvstXiSuQsyLzdCGMpdPIfaIUXQhvWY379b8E
         vOLjOSLjOgzdgpKpCRKMQcWcAM3+DVCVOKGAks5SHYco0x52G4dLkLuW5xSiAMbFWrQJ
         dH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rRbcFZTBsr5UTiQkJQRBFM2XGDOP8HlcShgJVsOH43g=;
        fh=FZMZoOkpa0KxThQyg8oBRQ9q9LAwgM2Hy1ZAr7sHrz8=;
        b=oE9QyCPxIzsPDbCbYf7ngkWUzL7uUwETRWTiSL26j9rUui+BUyk2RdGX8L6S14Iap+
         6Xo20cRKSv5ASFflaB9TZ5E8RIgywzg0eSAmsgM+jHgMX8Fbh+XTr71JqLArjja6UeNq
         kaRgUkPb59ceM8ksAa+yYz+xKtdhE7b/t/USA88SYMLxgyzvRRPAQDlLKYKp9hnj4GCt
         ErKwpQdK1K9+S2qHXWy3EdpMVr6WElI2AfpUt/UdjSlqHfqUe6fWLBoO4vlGjLMB0G9j
         bEbQhmrWhTi3tgcz8IZK8vRiwetq7pRwlLk1l6rbG5PSwgNwamJrwQyVGNHb8uYLDtfD
         qexg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790086636; x=1790691436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rRbcFZTBsr5UTiQkJQRBFM2XGDOP8HlcShgJVsOH43g=;
        b=VhPlUCmn5J+HMzcf6R04qSaYzBLXfwnDL0NYUXBAIjTCslMZ/ngTgjkoTH47OMB14s
         oZcN+A9L3jOuITCDhC2mcNfvcb0gM6nqeTOygmhddtc0ekyzrfLmqYUrnj8JBIGTX0P7
         pv9Uc+iwoC/ErRlCF92ZvDQuQFCrA6LcwITd8jyW3QbPySSoQ2W9YEV81o+GnUe4H9Th
         vVfD4GTyXBzSYwVShTLCnT1xPI45Gy7VhpZ3ooh33Ba9H6US8MC1r2GeeKJ/HPZfWfkp
         9gHnhB8dXCgW6+gfkG3aLZpQiXC2i2Qj+sh8PITjX+vaxYMFa+vuc/cYtvOyKLO/Ouod
         sjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790086636; x=1790691436;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rRbcFZTBsr5UTiQkJQRBFM2XGDOP8HlcShgJVsOH43g=;
        b=fV2g00q1MlB3LbcxX2+12z39QVsF+RkrJ9vPMQol7XFxpGHhaBFbubWHKGilS62UiB
         F0NRhMUHWdvsKOtXVh/YWIgSfKAClMJZbj7sQhG3R9HZmQ5BXM1i6AsRWZel8xAA1AVS
         O6qu0kwS7LRXBk1+LAvpT1ZlZDPM9rHUIVupwsDJNlFncawhcOg/pfCQE86HYGEkaIvW
         w5ozkmXk06WRx2CoaIpnw2jE+YlMfgBCKsL1TmLqwj5594XvgxS2i2quE1wyrVoIUro1
         Y40thZ/WDzKyhjrgIWmE6o7dBVusDG7cwzCuRGQWfNOSEo4cOMaL1ZDcXPOiFG8A1+HH
         rdxQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4005N793c92MnG5b/zpPrfoeeeH+Ibw3ocMIb8TBKvGb1ZuwNTSW9dymCajNNHUugTnc=@vger.kernel.org
X-Gm-Message-State: AFuF++nIP1VOf8ywH6O2zAStFN7gexgWsTDvtcbfMTMvFxmWKlbTKUev
	CHJK0o42QwC1M8UNfOVUwaFXzVAK4gnZYyQy3LmB8jFqgJvnB+E7JZUnWKzSjZ0yMHmAWZSiDq4
	kyCfKVJYTiVRY/pwW44lYFLTxFwV75sM=
X-Gm-Gg: AYBFou16I+g9cHS3iOJvMdQ2Bbkjz8DYkv+y3sfPRR+FoN9fsjw5cuZCe756c8SFve2
	n6Pyau+H2nDmptV98R8R2qDjk3R3v1vC8jLj2FQacbSCzmxz0Scr/l7vUvjrsuomgCttaFO5XTQ
	C4uxubKVZJX+LWv9MZoYpxOJ/OEvsKczK6UX3wK3nj/dpVGYP1z4dlgEm5r+FX3cr3rAFN3APMb
	/PI9yj3Vhz3k466GHDCfv6qjzQ0VIIqlcwsu4JFcOwfh9HJtc/IaP2yMR2yPv/jwZgWZDBJVETR
	ze1rWNzvIEeYsG4b3abMpgkPK7yzsW2vx0s/oje6Z4ORqimpP/eaxHUZ5kcsWLIGwop03mTGPbp
	FEvDB/w==
X-Received: by 2002:a17:906:c154:b0:c25:b706:e59 with SMTP id
 a640c23a62f3a-c2a156d8d11mr1242823166b.17.1790086635470; Tue, 22 Sep 2026
 07:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921191407.1742386-1-puranjay@kernel.org> <20260921191407.1742386-2-puranjay@kernel.org>
 <DLLGX9F9UG4Q.2YJWNSO4FXT1P@gmail.com>
In-Reply-To: <DLLGX9F9UG4Q.2YJWNSO4FXT1P@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 22 Sep 2026 15:17:01 +0100
X-Gm-Features: AclHuK9SSn36VMgwndkyN3QCAzyEuIWij-2EOYKbohV7wywhK4edre9gt73Wl6M
Message-ID: <CANk7y0hpi+vjXCR1oZBoeL8XLDss-HoufJfYkqNwRUXghFYCMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 2:53=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Sep 21, 2026 at 7:14 PM UTC, Puranjay Mohan wrote:
> > BPF programs that manage their own objects have no way to run their own
> > logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> > free, but returning an index to an allocator or unpinning a resource
> > once readers are done has no equivalent.  sched_ext's BPF library works
> > around this today by pushing freed nodes onto a list and having a
> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> > BPF program to reclaim them.
> >
> > Add:
> >
> >       int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> >                        int (*callback)(struct bpf_map *map, void *key,
> >                                        void *value));
> >
> > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> > callback runs as callback(map, key, value) for the element it lives in
> > and needs no cookie.  A head can only be armed once, which bounds
> > outstanding work by the number of elements.
> >
> > struct bpf_rcu_head holds the callback state inline rather than a
> > pointer to it, as bpf_timer, bpf_wq and bpf_task_work do, because there
> > is nothing to cancel and so nothing that has to outlive the map value.
> > That avoids an allocation and a state machine on the arming path at the
> > cost of 64 bytes per element, 48 of which are used today.  Embedding
> > struct rcu_head ties part of a uapi struct to a definition outside of
> > BPF, which is acceptable here only because it is two pointers, a
> > callback and its argument, with no room to grow.
> >
> > An RCU callback cannot be cancelled, so everything it touches has to
> > stay alive until it runs:
> >
> >   - The callback is the program's text, so arming takes a program
> >     reference as bpf_timer, bpf_wq and bpf_task_work do, dropped once
> >     the callback returns.  bpf_prog_inc_not_zero() also fails the arm
> >     with -EBADF once the program is dying.
> >
> >   - The map is held by that reference through used_maps.  An inner map
> >     is not, so bpf_rcu_head is rejected in one.
> >
> >   - The field is only accepted in BPF_MAP_TYPE_ARRAY, whose elements
> >     are never freed individually.  A hash element can be deleted and
> >     recycled while a callback is queued on it.
> >
> >   - The head is disarmed before the callback runs so it can be armed
> >     again from there, which takes a new program reference before the
> >     running callback drops its own.  Arming therefore fails with -EPERM
> >     once the map is held by neither a process nor bpffs, which is what
> >     bpf_timer and bpf_wq do at init time; bpf_task_work uses -EBUSY and
> >     additionally cancels, which is not possible here.
> >
> > bpf_iter hands a program a writable pointer to the live element, which
> > would let it overwrite a queued head, so bpf_iter_attach_map() rejects
> > maps carrying one.
> >
> > The callback is verified non-sleepable even when the caller is
> > sleepable, and RCU invokes it with BH disabled.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  include/linux/bpf.h            | 10 +++++
> >  include/uapi/linux/bpf.h       |  4 ++
> >  kernel/bpf/btf.c               |  7 +++
> >  kernel/bpf/helpers.c           | 75 +++++++++++++++++++++++++++++++
> >  kernel/bpf/map_in_map.c        |  4 ++
> >  kernel/bpf/map_iter.c          |  6 +++
> >  kernel/bpf/syscall.c           | 11 ++++-
> >  kernel/bpf/verifier.c          | 81 +++++++++++++++++++++++++++++++++-
> >  tools/include/uapi/linux/bpf.h |  4 ++
> >  9 files changed, 199 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index fd22db8bc6c50..e7c5e203edddb 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -215,6 +215,7 @@ enum btf_field_type {
> >       BPF_UPTR       =3D (1 << 11),
> >       BPF_RES_SPIN_LOCK =3D (1 << 12),
> >       BPF_TASK_WORK  =3D (1 << 13),
> > +     BPF_RCU_HEAD   =3D (1 << 14),
> >  };
> >
> >  enum bpf_cgroup_storage_type {
> > @@ -269,6 +270,7 @@ struct btf_record {
> >       int wq_off;
> >       int refcount_off;
> >       int task_work_off;
> > +     int rcu_head_off;
> >       struct btf_field fields[];
> >  };
> >
> > @@ -374,6 +376,8 @@ static inline const char *btf_field_type_name(enum =
btf_field_type type)
> >               return "bpf_refcount";
> >       case BPF_TASK_WORK:
> >               return "bpf_task_work";
> > +     case BPF_RCU_HEAD:
> > +             return "bpf_rcu_head";
> >       default:
> >               WARN_ON_ONCE(1);
> >               return "unknown";
> > @@ -414,6 +418,8 @@ static inline u32 btf_field_type_size(enum btf_fiel=
d_type type)
> >               return sizeof(struct bpf_refcount);
> >       case BPF_TASK_WORK:
> >               return sizeof(struct bpf_task_work);
> > +     case BPF_RCU_HEAD:
> > +             return sizeof(struct bpf_rcu_head);
> >       default:
> >               WARN_ON_ONCE(1);
> >               return 0;
> > @@ -448,6 +454,8 @@ static inline u32 btf_field_type_align(enum btf_fie=
ld_type type)
> >               return __alignof__(struct bpf_refcount);
> >       case BPF_TASK_WORK:
> >               return __alignof__(struct bpf_task_work);
> > +     case BPF_RCU_HEAD:
> > +             return __alignof__(struct bpf_rcu_head);
> >       default:
> >               WARN_ON_ONCE(1);
> >               return 0;
> > @@ -480,6 +488,7 @@ static inline void bpf_obj_init_field(const struct =
btf_field *field, void *addr)
> >       case BPF_KPTR_PERCPU:
> >       case BPF_UPTR:
> >       case BPF_TASK_WORK:
> > +     case BPF_RCU_HEAD:
> >               break;
> >       default:
> >               WARN_ON_ONCE(1);
> > @@ -925,6 +934,7 @@ enum bpf_arg_type {
> >       ARG_PTR_TO_RB_NODE,     /* pointer to bpf_rb_node */
> >       ARG_PTR_TO_WORKQUEUE,   /* pointer to bpf_wq */
> >       ARG_PTR_TO_TASK_WORK,   /* pointer to bpf_task_work */
> > +     ARG_PTR_TO_RCU_HEAD,    /* pointer to bpf_rcu_head */
> >       ARG_PTR_TO_IRQ_FLAG,    /* pointer to saved IRQ flags on the stac=
k */
> >       ARG_PTR_TO_RES_SPIN_LOCK,       /* pointer to bpf_res_spin_lock *=
/
> >       ARG_PTR_TO_CTX_OUT,     /* hook output argument passed through fr=
om ctx */
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 6330b7d745c57..eafeba23f5da7 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7611,6 +7611,10 @@ struct bpf_task_work {
> >       __u64 __opaque;
> >  } __attribute__((aligned(8)));
> >
> > +struct bpf_rcu_head {
> > +     __u64 __opaque[8];
> > +} __attribute__((aligned(8)));
> > +
> >  struct bpf_wq {
> >       __u64 __opaque[2];
> >  } __attribute__((aligned(8)));
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 314ecb0e593b0..4a1fa4fbdf4e8 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -3696,6 +3696,7 @@ static int btf_get_field_type(const struct btf *b=
tf, const struct btf_type *var_
> >               { BPF_TIMER, "bpf_timer", true },
> >               { BPF_WORKQUEUE, "bpf_wq", true },
> >               { BPF_TASK_WORK, "bpf_task_work", true },
> > +             { BPF_RCU_HEAD, "bpf_rcu_head", true },
> >               { BPF_LIST_HEAD, "bpf_list_head", false },
> >               { BPF_LIST_NODE, "bpf_list_node", false },
> >               { BPF_RB_ROOT, "bpf_rb_root", false },
> > @@ -3881,6 +3882,7 @@ static int btf_find_field_one(const struct btf *b=
tf,
> >       case BPF_RB_NODE:
> >       case BPF_REFCOUNT:
> >       case BPF_TASK_WORK:
> > +     case BPF_RCU_HEAD:
> >               ret =3D btf_find_struct(btf, var_type, off, sz, field_typ=
e,
> >                                     info_cnt ? &info[0] : &tmp);
> >               if (ret < 0)
> > @@ -4176,6 +4178,7 @@ struct btf_record *btf_parse_fields(const struct =
btf *btf, const struct btf_type
> >       rec->wq_off =3D -EINVAL;
> >       rec->refcount_off =3D -EINVAL;
> >       rec->task_work_off =3D -EINVAL;
> > +     rec->rcu_head_off =3D -EINVAL;
> >       for (i =3D 0; i < cnt; i++) {
> >               field_type_size =3D btf_field_type_size(info_arr[i].type)=
;
> >               if (info_arr[i].off + field_type_size > value_size) {
> > @@ -4219,6 +4222,10 @@ struct btf_record *btf_parse_fields(const struct=
 btf *btf, const struct btf_type
> >                       WARN_ON_ONCE(rec->task_work_off >=3D 0);
> >                       rec->task_work_off =3D rec->fields[i].offset;
> >                       break;
> > +             case BPF_RCU_HEAD:
> > +                     WARN_ON_ONCE(rec->rcu_head_off >=3D 0);
> > +                     rec->rcu_head_off =3D rec->fields[i].offset;
> > +                     break;
> >               case BPF_REFCOUNT:
> >                       WARN_ON_ONCE(rec->refcount_off >=3D 0);
> >                       /* Cache offset for faster lookup at runtime */
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 501c7ce35cba9..8a01dd4058a03 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -4805,6 +4805,80 @@ __bpf_kfunc int bpf_task_work_schedule_resume(st=
ruct task_struct *task, struct b
> >       return bpf_task_work_schedule(task, tw, map__const_map, callback,=
 aux, TWA_RESUME);
> >  }
> >
> > +typedef int (*bpf_rcu_callback_t)(struct bpf_map *map, void *key, void=
 *value);
> > +
> > +/* Actual type for struct bpf_rcu_head */
> > +struct bpf_rcu_head_kern {
> > +     struct rcu_head rcu;
> > +     bpf_callback_t callback_fn;
> > +     struct bpf_map *map;
> > +     struct bpf_prog *prog;
> > +     u32 armed;
> > +} __aligned(8);
> > +
> > +static void bpf_rcu_run_callback(struct rcu_head *rcu)
> > +{
> > +     struct bpf_rcu_head_kern *rh =3D container_of(rcu, struct bpf_rcu=
_head_kern, rcu);
> > +     bpf_callback_t callback_fn =3D rh->callback_fn;
> > +     struct bpf_prog *prog =3D rh->prog;
> > +     struct bpf_map *map =3D rh->map;
> > +     void *value, *key;
> > +     u32 idx;
> > +
> > +     value =3D (void *)rh - map->record->rcu_head_off;
> > +     key =3D map_key_from_value(map, value, &idx);
> > +
> > +     /* Pairs with the arming cmpxchg(): rh may be re-armed as soon as=
 this store lands. */
> > +     smp_store_release(&rh->armed, 0);
> > +
> > +     rcu_read_lock_dont_migrate();
> > +     callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, =
0);
> > +     rcu_read_unlock_migrate();
> > +
> > +     bpf_prog_put(prog);
> > +}
> > +
> > +/**
> > + * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
> > + * @rh: struct bpf_rcu_head in a BPF map value
> > + * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the val=
ues
> > + * @callback: BPF subprogram, invoked as callback(map, key, value) for=
 the value holding @rh
> > + * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
> > + *
> > + * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held =
by neither a process
> > + * nor bpffs, or -EBADF if the calling program is going away.
> > + */
> > +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const=
_map,
> > +                          bpf_rcu_callback_t callback, struct bpf_prog=
_aux *aux)
> > +{
> > +     struct bpf_rcu_head_kern *rhk =3D (void *)rh;
> > +     struct bpf_map *map =3D map__const_map;
> > +     struct bpf_prog *prog;
> > +
> > +     BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf=
_rcu_head));
> > +     BUILD_BUG_ON(__alignof__(struct bpf_rcu_head_kern) !=3D __alignof=
__(struct bpf_rcu_head));
> > +     BTF_TYPE_EMIT(struct bpf_rcu_head);
> > +
> > +     /* A queued callback cannot be cancelled, so a self-rearming one =
would pin prog and map. */
> > +     if (!atomic64_read(&map->usercnt))
> > +             return -EPERM;
> > +
> > +     if (cmpxchg(&rhk->armed, 0, 1))
> > +             return -EBUSY;
> > +
> > +     prog =3D bpf_prog_inc_not_zero(aux->prog);
> > +     if (IS_ERR(prog)) {
> > +             WRITE_ONCE(rhk->armed, 0);
> > +             return -EBADF;
> > +     }
>
> can we drop prog_inc and remove prog pointer from rhk ?
> with something like if (prog->has_call_rcu) rcu_barrier() during prog unl=
oad?

That could work but we would need more than just the calls to
rcu_barrier_tasks_trace() and/or  rcu_barrier(). As the rcu_barrier
only waits for callbacks enqueued before it was called, the registered
callback and re-queue itself and cause problems. So, we would need a
flag that is set before the call to rcu_barrier() which stops further
queueing of callbacks from that program. Also, assuming we add these
barrier calls in bpf_prog_free_deferred() which is runs from
system_percpu_wq, it could make this run for much longer than
expected. What is the motivation for using rcu_barrier() instead of
bpf_prog_inc_not_zero()? is it the 8B pointer in rhk or the atomic
operation in bpf_prog_inc_not_zero()?
