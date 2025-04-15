Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE31B0430;
	Tue, 15 Apr 2025 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739927; cv=none; b=jRUhroOmuyjJXNHeyW/jqZLsAonGfmCkvr7om/1rc7s70gBe+CTxSlusB/CTl3Sr0K6WWTJuDyGeOY5SM2Jv8XHpmJikO04Djumu/FTzYAB0GlzLdkBf8OK4CBycqIONx9m9NU0onJko8fiuL8GRuM7JsSOd5nKz3zCP1d1QQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739927; c=relaxed/simple;
	bh=eiIb9HwkQyWvL5Tvc54h4ijpJMh9dg1ZjUfpu2LrEp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtBUq6O19Q7+mcnX29EjrBD36ihOek/2mJ51qtp7bJCV1mhjBG/s2loque18DHx9r6MTqJqG5lPWMKS7Y7CLEf2KHHnq2XyQwuyabaGu3qzKN7up+N8/DVpoLbQr+rxzgjgKImKl6zpdJQAUcqif5XTIhvwRwrkn96MDYbluBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWCQSmHx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWCQSmHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECBEC4CEE9;
	Tue, 15 Apr 2025 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744739926;
	bh=eiIb9HwkQyWvL5Tvc54h4ijpJMh9dg1ZjUfpu2LrEp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZWCQSmHxaON8N9M9GZnsUqfKP1bioh4GUgcHV0XgCuBI9feZWkH3Ndla++Ecr112q
	 ZsNC2Ez/mGfHYPX9jqbDQDcIK+Kjo2cE9N4tYjR1iapdD1+fjk0ajnn0/nSDbV6SHw
	 nxw+wQ05FpbRhIlmqcIP0JWR1rBs2oPavd26lwYBfrhzEIiOYmHQk8vLgJyLqNsDK1
	 Plxv6PSKvWxf1J895jaPesqMHZQhQtD7T1lqkdkweA5YdgyByDr1WY0wo7rQhm8NMe
	 ClxN1WT5ewxEm3HKAwr10F2W9icDPJ58QScUqfYpwGzgdljj9pPk79OlHBOV2N4jV+
	 brDFFGbCde8xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B830CE04F2; Tue, 15 Apr 2025 10:58:41 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:58:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: move mmap/vma locking logic into specific files
Message-ID: <70ff330e-b199-4c0a-bfda-478b3e50de80@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1744720574.git.lorenzo.stoakes@oracle.com>
 <acd557ff58c49aec6a83955b62de026687a79fa9.1744720574.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpHg8ru9a3jQFaGRqJA0hpTODXXstqbLAJqy7bH9RfpE7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHg8ru9a3jQFaGRqJA0hpTODXXstqbLAJqy7bH9RfpE7Q@mail.gmail.com>

On Tue, Apr 15, 2025 at 09:06:46AM -0700, Suren Baghdasaryan wrote:
> On Tue, Apr 15, 2025 at 6:11 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Currently the VMA and mmap locking logic is entangled in two of the most
> > overwrought files in mm - include/linux/mm.h and mm/memory.c. Separate this
> > logic out so we can more easily make changes and create an appropriate
> > MAINTAINERS entry that spans only the logic relating to locking.
> >
> > This should have no functional change. Care is taken to avoid dependency
> > loops, we must regrettably keep release_fault_lock() and
> > assert_fault_locked() in mm.h as a result due to the dependence on the
> > vm_fault type.
> >
> > Additionally we must declare rcuwait_wake_up() manually to avoid a
> > dependency cycle on linux/rcuwait.h.
> 
> The king of refactoring strikes again :)

Should us RCU guys be doing something different to make this less of
a problem?

							Thanx, Paul

> On a serious note, thanks a lot for doing this! The code is much more
> organized this way IMO.
> I noticed a couple nits (see below) but otherwise LGTM. With those
> addressed feel free to add:
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/mm.h        | 231 +---------------------------------
> >  include/linux/mmap_lock.h | 227 +++++++++++++++++++++++++++++++++
> >  mm/memory.c               | 252 -------------------------------------
> >  mm/mmap_lock.c            | 255 ++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 486 insertions(+), 479 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 5eb0d77c4438..9b701cfbef22 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -671,204 +671,11 @@ static inline void vma_numab_state_init(struct vm_area_struct *vma) {}
> >  static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
> >  #endif /* CONFIG_NUMA_BALANCING */
> >
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
> > -{
> > -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > -       static struct lock_class_key lockdep_key;
> > -
> > -       lockdep_init_map(&vma->vmlock_dep_map, "vm_lock", &lockdep_key, 0);
> > -#endif
> > -       if (reset_refcnt)
> > -               refcount_set(&vma->vm_refcnt, 0);
> > -       vma->vm_lock_seq = UINT_MAX;
> > -}
> > -
> > -static inline bool is_vma_writer_only(int refcnt)
> > -{
> > -       /*
> > -        * With a writer and no readers, refcnt is VMA_LOCK_OFFSET if the vma
> > -        * is detached and (VMA_LOCK_OFFSET + 1) if it is attached. Waiting on
> > -        * a detached vma happens only in vma_mark_detached() and is a rare
> > -        * case, therefore most of the time there will be no unnecessary wakeup.
> > -        */
> > -       return refcnt & VMA_LOCK_OFFSET && refcnt <= VMA_LOCK_OFFSET + 1;
> > -}
> > -
> > -static inline void vma_refcount_put(struct vm_area_struct *vma)
> > -{
> > -       /* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
> > -       struct mm_struct *mm = vma->vm_mm;
> > -       int oldcnt;
> > -
> > -       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > -       if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
> > -
> > -               if (is_vma_writer_only(oldcnt - 1))
> > -                       rcuwait_wake_up(&mm->vma_writer_wait);
> > -       }
> > -}
> > -
> > -/*
> > - * Try to read-lock a vma. The function is allowed to occasionally yield false
> > - * locked result to avoid performance overhead, in which case we fall back to
> > - * using mmap_lock. The function should never yield false unlocked result.
> > - * False locked result is possible if mm_lock_seq overflows or if vma gets
> > - * reused and attached to a different mm before we lock it.
> > - * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
> > - * detached.
> > - */
> > -static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > -                                                   struct vm_area_struct *vma)
> > -{
> > -       int oldcnt;
> > -
> > -       /*
> > -        * Check before locking. A race might cause false locked result.
> > -        * We can use READ_ONCE() for the mm_lock_seq here, and don't need
> > -        * ACQUIRE semantics, because this is just a lockless check whose result
> > -        * we don't rely on for anything - the mm_lock_seq read against which we
> > -        * need ordering is below.
> > -        */
> > -       if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
> > -               return NULL;
> > -
> > -       /*
> > -        * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acquire()
> > -        * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
> > -        * Acquire fence is required here to avoid reordering against later
> > -        * vm_lock_seq check and checks inside lock_vma_under_rcu().
> > -        */
> > -       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
> > -                                                             VMA_REF_LIMIT))) {
> > -               /* return EAGAIN if vma got detached from under us */
> > -               return oldcnt ? NULL : ERR_PTR(-EAGAIN);
> > -       }
> > -
> > -       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > -       /*
> > -        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
> > -        * False unlocked result is impossible because we modify and check
> > -        * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
> > -        * modification invalidates all existing locks.
> > -        *
> > -        * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
> > -        * racing with vma_end_write_all(), we only start reading from the VMA
> > -        * after it has been unlocked.
> > -        * This pairs with RELEASE semantics in vma_end_write_all().
> > -        */
> > -       if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
> > -               vma_refcount_put(vma);
> > -               return NULL;
> > -       }
> > -
> > -       return vma;
> > -}
> > -
> > -/*
> > - * Use only while holding mmap read lock which guarantees that locking will not
> > - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > - * not be used in such cases because it might fail due to mm_lock_seq overflow.
> > - * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > - */
> > -static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
> > -{
> > -       int oldcnt;
> > -
> > -       mmap_assert_locked(vma->vm_mm);
> > -       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
> > -                                                             VMA_REF_LIMIT)))
> > -               return false;
> > -
> > -       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > -       return true;
> > -}
> > -
> > -/*
> > - * Use only while holding mmap read lock which guarantees that locking will not
> > - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > - * not be used in such cases because it might fail due to mm_lock_seq overflow.
> > - * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > - */
> > -static inline bool vma_start_read_locked(struct vm_area_struct *vma)
> > -{
> > -       return vma_start_read_locked_nested(vma, 0);
> > -}
> > -
> > -static inline void vma_end_read(struct vm_area_struct *vma)
> > -{
> > -       vma_refcount_put(vma);
> > -}
> > -
> > -/* WARNING! Can only be used if mmap_lock is expected to be write-locked */
> > -static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
> > -{
> > -       mmap_assert_write_locked(vma->vm_mm);
> > -
> > -       /*
> > -        * current task is holding mmap_write_lock, both vma->vm_lock_seq and
> > -        * mm->mm_lock_seq can't be concurrently modified.
> > -        */
> > -       *mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
> > -       return (vma->vm_lock_seq == *mm_lock_seq);
> > -}
> > -
> > -void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq);
> > -
> > -/*
> > - * Begin writing to a VMA.
> > - * Exclude concurrent readers under the per-VMA lock until the currently
> > - * write-locked mmap_lock is dropped or downgraded.
> > - */
> > -static inline void vma_start_write(struct vm_area_struct *vma)
> > -{
> > -       unsigned int mm_lock_seq;
> > -
> > -       if (__is_vma_write_locked(vma, &mm_lock_seq))
> > -               return;
> > -
> > -       __vma_start_write(vma, mm_lock_seq);
> > -}
> > -
> > -static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > -{
> > -       unsigned int mm_lock_seq;
> > -
> > -       VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
> > -}
> > -
> > -static inline void vma_assert_locked(struct vm_area_struct *vma)
> > -{
> > -       unsigned int mm_lock_seq;
> > -
> > -       VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
> > -                     !__is_vma_write_locked(vma, &mm_lock_seq), vma);
> > -}
> > -
> >  /*
> > - * WARNING: to avoid racing with vma_mark_attached()/vma_mark_detached(), these
> > - * assertions should be made either under mmap_write_lock or when the object
> > - * has been isolated under mmap_write_lock, ensuring no competing writers.
> > + * These must be here rather than mmap_lock.h as dependent on vm_fault type,
> > + * declared in this header.
> >   */
> > -static inline void vma_assert_attached(struct vm_area_struct *vma)
> > -{
> > -       WARN_ON_ONCE(!refcount_read(&vma->vm_refcnt));
> > -}
> > -
> > -static inline void vma_assert_detached(struct vm_area_struct *vma)
> > -{
> > -       WARN_ON_ONCE(refcount_read(&vma->vm_refcnt));
> > -}
> > -
> > -static inline void vma_mark_attached(struct vm_area_struct *vma)
> > -{
> > -       vma_assert_write_locked(vma);
> > -       vma_assert_detached(vma);
> > -       refcount_set_release(&vma->vm_refcnt, 1);
> > -}
> > -
> > -void vma_mark_detached(struct vm_area_struct *vma);
> > -
> > +#ifdef CONFIG_PER_VMA_LOCK
> >  static inline void release_fault_lock(struct vm_fault *vmf)
> >  {
> >         if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > @@ -884,36 +691,7 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
> >         else
> >                 mmap_assert_locked(vmf->vma->vm_mm);
> >  }
> > -
> > -struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > -                                         unsigned long address);
> > -
> > -#else /* CONFIG_PER_VMA_LOCK */
> > -
> > -static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt) {}
> > -static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > -                                                   struct vm_area_struct *vma)
> > -               { return NULL; }
> > -static inline void vma_end_read(struct vm_area_struct *vma) {}
> > -static inline void vma_start_write(struct vm_area_struct *vma) {}
> > -static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > -               { mmap_assert_write_locked(vma->vm_mm); }
> > -static inline void vma_assert_attached(struct vm_area_struct *vma) {}
> > -static inline void vma_assert_detached(struct vm_area_struct *vma) {}
> > -static inline void vma_mark_attached(struct vm_area_struct *vma) {}
> > -static inline void vma_mark_detached(struct vm_area_struct *vma) {}
> > -
> > -static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > -               unsigned long address)
> > -{
> > -       return NULL;
> > -}
> > -
> > -static inline void vma_assert_locked(struct vm_area_struct *vma)
> > -{
> > -       mmap_assert_locked(vma->vm_mm);
> > -}
> > -
> > +#else
> >  static inline void release_fault_lock(struct vm_fault *vmf)
> >  {
> >         mmap_read_unlock(vmf->vma->vm_mm);
> > @@ -923,7 +701,6 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
> >  {
> >         mmap_assert_locked(vmf->vma->vm_mm);
> >  }
> > -
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> >  extern const struct vm_operations_struct vma_dummy_vm_ops;
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 4706c6769902..7983b2efe9bf 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -1,6 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> >  #ifndef _LINUX_MMAP_LOCK_H
> >  #define _LINUX_MMAP_LOCK_H
> >
> > +/* Avoid a dependency loop by declaring here. */
> > +extern int rcuwait_wake_up(struct rcuwait *w);
> > +
> >  #include <linux/lockdep.h>
> >  #include <linux/mm_types.h>
> >  #include <linux/mmdebug.h>
> > @@ -104,6 +108,206 @@ static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int
> >         return read_seqcount_retry(&mm->mm_lock_seq, seq);
> >  }
> >
> > +static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
> > +{
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +       static struct lock_class_key lockdep_key;
> > +
> > +       lockdep_init_map(&vma->vmlock_dep_map, "vm_lock", &lockdep_key, 0);
> > +#endif
> > +       if (reset_refcnt)
> > +               refcount_set(&vma->vm_refcnt, 0);
> > +       vma->vm_lock_seq = UINT_MAX;
> > +}
> > +
> > +static inline bool is_vma_writer_only(int refcnt)
> > +{
> > +       /*
> > +        * With a writer and no readers, refcnt is VMA_LOCK_OFFSET if the vma
> > +        * is detached and (VMA_LOCK_OFFSET + 1) if it is attached. Waiting on
> > +        * a detached vma happens only in vma_mark_detached() and is a rare
> > +        * case, therefore most of the time there will be no unnecessary wakeup.
> > +        */
> > +       return refcnt & VMA_LOCK_OFFSET && refcnt <= VMA_LOCK_OFFSET + 1;
> > +}
> > +
> > +static inline void vma_refcount_put(struct vm_area_struct *vma)
> > +{
> > +       /* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
> > +       struct mm_struct *mm = vma->vm_mm;
> > +       int oldcnt;
> > +
> > +       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > +       if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
> > +
> > +               if (is_vma_writer_only(oldcnt - 1))
> > +                       rcuwait_wake_up(&mm->vma_writer_wait);
> > +       }
> > +}
> > +
> > +/*
> > + * Try to read-lock a vma. The function is allowed to occasionally yield false
> > + * locked result to avoid performance overhead, in which case we fall back to
> > + * using mmap_lock. The function should never yield false unlocked result.
> > + * False locked result is possible if mm_lock_seq overflows or if vma gets
> > + * reused and attached to a different mm before we lock it.
> > + * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
> > + * detached.
> > + */
> > +static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > +                                                   struct vm_area_struct *vma)
> > +{
> > +       int oldcnt;
> > +
> > +       /*
> > +        * Check before locking. A race might cause false locked result.
> > +        * We can use READ_ONCE() for the mm_lock_seq here, and don't need
> > +        * ACQUIRE semantics, because this is just a lockless check whose result
> > +        * we don't rely on for anything - the mm_lock_seq read against which we
> > +        * need ordering is below.
> > +        */
> > +       if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
> > +               return NULL;
> > +
> > +       /*
> > +        * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acquire()
> > +        * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
> > +        * Acquire fence is required here to avoid reordering against later
> > +        * vm_lock_seq check and checks inside lock_vma_under_rcu().
> > +        */
> > +       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
> > +                                                             VMA_REF_LIMIT))) {
> > +               /* return EAGAIN if vma got detached from under us */
> > +               return oldcnt ? NULL : ERR_PTR(-EAGAIN);
> > +       }
> > +
> > +       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > +       /*
> > +        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
> > +        * False unlocked result is impossible because we modify and check
> > +        * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
> > +        * modification invalidates all existing locks.
> > +        *
> > +        * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
> > +        * racing with vma_end_write_all(), we only start reading from the VMA
> > +        * after it has been unlocked.
> > +        * This pairs with RELEASE semantics in vma_end_write_all().
> > +        */
> > +       if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
> > +               vma_refcount_put(vma);
> > +               return NULL;
> > +       }
> > +
> > +       return vma;
> > +}
> > +
> > +/*
> > + * Use only while holding mmap read lock which guarantees that locking will not
> > + * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > + * not be used in such cases because it might fail due to mm_lock_seq overflow.
> > + * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > + */
> > +static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
> > +{
> > +       int oldcnt;
> > +
> > +       mmap_assert_locked(vma->vm_mm);
> > +       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
> > +                                                             VMA_REF_LIMIT)))
> > +               return false;
> > +
> > +       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > +       return true;
> > +}
> > +
> > +/*
> > + * Use only while holding mmap read lock which guarantees that locking will not
> > + * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > + * not be used in such cases because it might fail due to mm_lock_seq overflow.
> > + * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > + */
> > +static inline bool vma_start_read_locked(struct vm_area_struct *vma)
> > +{
> > +       return vma_start_read_locked_nested(vma, 0);
> > +}
> > +
> > +static inline void vma_end_read(struct vm_area_struct *vma)
> > +{
> > +       vma_refcount_put(vma);
> > +}
> > +
> > +/* WARNING! Can only be used if mmap_lock is expected to be write-locked */
> > +static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
> > +{
> > +       mmap_assert_write_locked(vma->vm_mm);
> > +
> > +       /*
> > +        * current task is holding mmap_write_lock, both vma->vm_lock_seq and
> > +        * mm->mm_lock_seq can't be concurrently modified.
> > +        */
> > +       *mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
> > +       return (vma->vm_lock_seq == *mm_lock_seq);
> > +}
> > +
> > +void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq);
> > +
> > +/*
> > + * Begin writing to a VMA.
> > + * Exclude concurrent readers under the per-VMA lock until the currently
> > + * write-locked mmap_lock is dropped or downgraded.
> > + */
> > +static inline void vma_start_write(struct vm_area_struct *vma)
> > +{
> > +       unsigned int mm_lock_seq;
> > +
> > +       if (__is_vma_write_locked(vma, &mm_lock_seq))
> > +               return;
> > +
> > +       __vma_start_write(vma, mm_lock_seq);
> > +}
> > +
> > +static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > +{
> > +       unsigned int mm_lock_seq;
> > +
> > +       VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
> > +}
> > +
> > +static inline void vma_assert_locked(struct vm_area_struct *vma)
> > +{
> > +       unsigned int mm_lock_seq;
> > +
> > +       VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
> > +                     !__is_vma_write_locked(vma, &mm_lock_seq), vma);
> > +}
> > +
> > +/*
> > + * WARNING: to avoid racing with vma_mark_attached()/vma_mark_detached(), these
> > + * assertions should be made either under mmap_write_lock or when the object
> > + * has been isolated under mmap_write_lock, ensuring no competing writers.
> > + */
> > +static inline void vma_assert_attached(struct vm_area_struct *vma)
> > +{
> > +       WARN_ON_ONCE(!refcount_read(&vma->vm_refcnt));
> > +}
> > +
> > +static inline void vma_assert_detached(struct vm_area_struct *vma)
> > +{
> > +       WARN_ON_ONCE(refcount_read(&vma->vm_refcnt));
> > +}
> > +
> > +static inline void vma_mark_attached(struct vm_area_struct *vma)
> > +{
> > +       vma_assert_write_locked(vma);
> > +       vma_assert_detached(vma);
> > +       refcount_set_release(&vma->vm_refcnt, 1);
> > +}
> > +
> > +void vma_mark_detached(struct vm_area_struct *vma);
> > +
> > +struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > +                                         unsigned long address);
> > +
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> > @@ -119,6 +323,29 @@ static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int
> >  {
> >         return true;
> >  }
> > +static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt) {}
> > +static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > +                                                   struct vm_area_struct *vma)
> > +               { return NULL; }
> > +static inline void vma_end_read(struct vm_area_struct *vma) {}
> > +static inline void vma_start_write(struct vm_area_struct *vma) {}
> > +static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > +               { mmap_assert_write_locked(vma->vm_mm); }
> > +static inline void vma_assert_attached(struct vm_area_struct *vma) {}
> > +static inline void vma_assert_detached(struct vm_area_struct *vma) {}
> > +static inline void vma_mark_attached(struct vm_area_struct *vma) {}
> > +static inline void vma_mark_detached(struct vm_area_struct *vma) {}
> > +
> > +static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > +               unsigned long address)
> > +{
> > +       return NULL;
> > +}
> > +
> > +static inline void vma_assert_locked(struct vm_area_struct *vma)
> > +{
> > +       mmap_assert_locked(vma->vm_mm);
> > +}
> >
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 688f3612e16d..35cfc91d5a2e 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6378,258 +6378,6 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> >  }
> >  EXPORT_SYMBOL_GPL(handle_mm_fault);
> >
> > -#ifdef CONFIG_LOCK_MM_AND_FIND_VMA
> > -#include <linux/extable.h>
> > -
> > -static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
> > -{
> > -       if (likely(mmap_read_trylock(mm)))
> > -               return true;
> > -
> > -       if (regs && !user_mode(regs)) {
> > -               unsigned long ip = exception_ip(regs);
> > -               if (!search_exception_tables(ip))
> > -                       return false;
> > -       }
> > -
> > -       return !mmap_read_lock_killable(mm);
> > -}
> > -
> > -static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
> > -{
> > -       /*
> > -        * We don't have this operation yet.
> > -        *
> > -        * It should be easy enough to do: it's basically a
> > -        *    atomic_long_try_cmpxchg_acquire()
> > -        * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
> > -        * it also needs the proper lockdep magic etc.
> > -        */
> > -       return false;
> > -}
> > -
> > -static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
> > -{
> > -       mmap_read_unlock(mm);
> > -       if (regs && !user_mode(regs)) {
> > -               unsigned long ip = exception_ip(regs);
> > -               if (!search_exception_tables(ip))
> > -                       return false;
> > -       }
> > -       return !mmap_write_lock_killable(mm);
> > -}
> > -
> > -/*
> > - * Helper for page fault handling.
> > - *
> > - * This is kind of equivalent to "mmap_read_lock()" followed
> > - * by "find_extend_vma()", except it's a lot more careful about
> > - * the locking (and will drop the lock on failure).
> > - *
> > - * For example, if we have a kernel bug that causes a page
> > - * fault, we don't want to just use mmap_read_lock() to get
> > - * the mm lock, because that would deadlock if the bug were
> > - * to happen while we're holding the mm lock for writing.
> > - *
> > - * So this checks the exception tables on kernel faults in
> > - * order to only do this all for instructions that are actually
> > - * expected to fault.
> > - *
> > - * We can also actually take the mm lock for writing if we
> > - * need to extend the vma, which helps the VM layer a lot.
> > - */
> > -struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
> > -                       unsigned long addr, struct pt_regs *regs)
> > -{
> > -       struct vm_area_struct *vma;
> > -
> > -       if (!get_mmap_lock_carefully(mm, regs))
> > -               return NULL;
> > -
> > -       vma = find_vma(mm, addr);
> > -       if (likely(vma && (vma->vm_start <= addr)))
> > -               return vma;
> > -
> > -       /*
> > -        * Well, dang. We might still be successful, but only
> > -        * if we can extend a vma to do so.
> > -        */
> > -       if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
> > -               mmap_read_unlock(mm);
> > -               return NULL;
> > -       }
> > -
> > -       /*
> > -        * We can try to upgrade the mmap lock atomically,
> > -        * in which case we can continue to use the vma
> > -        * we already looked up.
> > -        *
> > -        * Otherwise we'll have to drop the mmap lock and
> > -        * re-take it, and also look up the vma again,
> > -        * re-checking it.
> > -        */
> > -       if (!mmap_upgrade_trylock(mm)) {
> > -               if (!upgrade_mmap_lock_carefully(mm, regs))
> > -                       return NULL;
> > -
> > -               vma = find_vma(mm, addr);
> > -               if (!vma)
> > -                       goto fail;
> > -               if (vma->vm_start <= addr)
> > -                       goto success;
> > -               if (!(vma->vm_flags & VM_GROWSDOWN))
> > -                       goto fail;
> > -       }
> > -
> > -       if (expand_stack_locked(vma, addr))
> > -               goto fail;
> > -
> > -success:
> > -       mmap_write_downgrade(mm);
> > -       return vma;
> > -
> > -fail:
> > -       mmap_write_unlock(mm);
> > -       return NULL;
> > -}
> > -#endif
> > -
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -static inline bool __vma_enter_locked(struct vm_area_struct *vma, bool detaching)
> > -{
> > -       unsigned int tgt_refcnt = VMA_LOCK_OFFSET;
> > -
> > -       /* Additional refcnt if the vma is attached. */
> > -       if (!detaching)
> > -               tgt_refcnt++;
> > -
> > -       /*
> > -        * If vma is detached then only vma_mark_attached() can raise the
> > -        * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attached().
> > -        */
> > -       if (!refcount_add_not_zero(VMA_LOCK_OFFSET, &vma->vm_refcnt))
> > -               return false;
> > -
> > -       rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> > -       rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
> > -                  refcount_read(&vma->vm_refcnt) == tgt_refcnt,
> > -                  TASK_UNINTERRUPTIBLE);
> > -       lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> > -
> > -       return true;
> > -}
> > -
> > -static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *detached)
> > -{
> > -       *detached = refcount_sub_and_test(VMA_LOCK_OFFSET, &vma->vm_refcnt);
> > -       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > -}
> > -
> > -void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
> > -{
> > -       bool locked;
> > -
> > -       /*
> > -        * __vma_enter_locked() returns false immediately if the vma is not
> > -        * attached, otherwise it waits until refcnt is indicating that vma
> > -        * is attached with no readers.
> > -        */
> > -       locked = __vma_enter_locked(vma, false);
> > -
> > -       /*
> > -        * We should use WRITE_ONCE() here because we can have concurrent reads
> > -        * from the early lockless pessimistic check in vma_start_read().
> > -        * We don't really care about the correctness of that early check, but
> > -        * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
> > -        */
> > -       WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > -
> > -       if (locked) {
> > -               bool detached;
> > -
> > -               __vma_exit_locked(vma, &detached);
> > -               WARN_ON_ONCE(detached); /* vma should remain attached */
> > -       }
> > -}
> > -EXPORT_SYMBOL_GPL(__vma_start_write);
> > -
> > -void vma_mark_detached(struct vm_area_struct *vma)
> > -{
> > -       vma_assert_write_locked(vma);
> > -       vma_assert_attached(vma);
> > -
> > -       /*
> > -        * We are the only writer, so no need to use vma_refcount_put().
> > -        * The condition below is unlikely because the vma has been already
> > -        * write-locked and readers can increment vm_refcnt only temporarily
> > -        * before they check vm_lock_seq, realize the vma is locked and drop
> > -        * back the vm_refcnt. That is a narrow window for observing a raised
> > -        * vm_refcnt.
> > -        */
> > -       if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
> > -               /* Wait until vma is detached with no readers. */
> > -               if (__vma_enter_locked(vma, true)) {
> > -                       bool detached;
> > -
> > -                       __vma_exit_locked(vma, &detached);
> > -                       WARN_ON_ONCE(!detached);
> > -               }
> > -       }
> > -}
> > -
> > -/*
> > - * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
> > - * stable and not isolated. If the VMA is not found or is being modified the
> > - * function returns NULL.
> > - */
> > -struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > -                                         unsigned long address)
> > -{
> > -       MA_STATE(mas, &mm->mm_mt, address, address);
> > -       struct vm_area_struct *vma;
> > -
> > -       rcu_read_lock();
> > -retry:
> > -       vma = mas_walk(&mas);
> > -       if (!vma)
> > -               goto inval;
> > -
> > -       vma = vma_start_read(mm, vma);
> > -       if (IS_ERR_OR_NULL(vma)) {
> > -               /* Check if the VMA got isolated after we found it */
> > -               if (PTR_ERR(vma) == -EAGAIN) {
> > -                       count_vm_vma_lock_event(VMA_LOCK_MISS);
> > -                       /* The area was replaced with another one */
> > -                       goto retry;
> > -               }
> > -
> > -               /* Failed to lock the VMA */
> > -               goto inval;
> > -       }
> > -       /*
> > -        * At this point, we have a stable reference to a VMA: The VMA is
> > -        * locked and we know it hasn't already been isolated.
> > -        * From here on, we can access the VMA without worrying about which
> > -        * fields are accessible for RCU readers.
> > -        */
> > -
> > -       /* Check if the vma we locked is the right one. */
> > -       if (unlikely(vma->vm_mm != mm ||
> > -                    address < vma->vm_start || address >= vma->vm_end))
> > -               goto inval_end_read;
> > -
> > -       rcu_read_unlock();
> > -       return vma;
> > -
> > -inval_end_read:
> > -       vma_end_read(vma);
> > -inval:
> > -       rcu_read_unlock();
> > -       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> > -       return NULL;
> > -}
> > -#endif /* CONFIG_PER_VMA_LOCK */
> > -
> >  #ifndef __PAGETABLE_P4D_FOLDED
> >  /*
> >   * Allocate p4d page table.
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index e7dbaf96aa17..7e4a1f467a46 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -42,3 +42,258 @@ void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
> >  }
> >  EXPORT_SYMBOL(__mmap_lock_do_trace_released);
> >  #endif /* CONFIG_TRACING */
> > +
> > +#ifdef CONFIG_MMU
> 
> I think we should also move NOMMU version of lock_mm_and_find_vma()
> into this file and these #ifdefs will become:
> 
> #ifdef CONFIG_PER_VMA_LOCK
> ...
> #endif /* CONFIG_PER_VMA_LOCK */
> 
> #ifdef CONFIG_MMU
>     #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
>     // MMU version of lock_mm_and_find_vma() and helpers
>     #endif /* CONFIG_LOCK_MM_AND_FIND_VMA */
> #else /* CONFIG_MMU */
>     // NOMMU version of lock_mm_and_find_vma()
> #endif /* CONFIG_MMU */
> 
> Note that CONFIG_PER_VMA_LOCK already depends on CONFIG_NOMMU.
> 
> Also something I just noticed. Are we missing lock_mm_and_find_vma()
> implementation for CONFIG_MMU && !CONFIG_LOCK_MM_AND_FIND_VMA ? I'm
> guessing architectures with !CONFIG_STACK_GROWSUP just don't use this
> function?
> 
> 
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +static inline bool __vma_enter_locked(struct vm_area_struct *vma, bool detaching)
> > +{
> > +       unsigned int tgt_refcnt = VMA_LOCK_OFFSET;
> > +
> > +       /* Additional refcnt if the vma is attached. */
> > +       if (!detaching)
> > +               tgt_refcnt++;
> > +
> > +       /*
> > +        * If vma is detached then only vma_mark_attached() can raise the
> > +        * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attached().
> > +        */
> > +       if (!refcount_add_not_zero(VMA_LOCK_OFFSET, &vma->vm_refcnt))
> > +               return false;
> > +
> > +       rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> > +       rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
> > +                  refcount_read(&vma->vm_refcnt) == tgt_refcnt,
> > +                  TASK_UNINTERRUPTIBLE);
> > +       lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> > +
> > +       return true;
> > +}
> > +
> > +static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *detached)
> > +{
> > +       *detached = refcount_sub_and_test(VMA_LOCK_OFFSET, &vma->vm_refcnt);
> > +       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > +}
> > +
> > +void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
> > +{
> > +       bool locked;
> > +
> > +       /*
> > +        * __vma_enter_locked() returns false immediately if the vma is not
> > +        * attached, otherwise it waits until refcnt is indicating that vma
> > +        * is attached with no readers.
> > +        */
> > +       locked = __vma_enter_locked(vma, false);
> > +
> > +       /*
> > +        * We should use WRITE_ONCE() here because we can have concurrent reads
> > +        * from the early lockless pessimistic check in vma_start_read().
> > +        * We don't really care about the correctness of that early check, but
> > +        * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
> > +        */
> > +       WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > +
> > +       if (locked) {
> > +               bool detached;
> > +
> > +               __vma_exit_locked(vma, &detached);
> > +               WARN_ON_ONCE(detached); /* vma should remain attached */
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(__vma_start_write);
> > +
> > +void vma_mark_detached(struct vm_area_struct *vma)
> > +{
> > +       vma_assert_write_locked(vma);
> > +       vma_assert_attached(vma);
> > +
> > +       /*
> > +        * We are the only writer, so no need to use vma_refcount_put().
> > +        * The condition below is unlikely because the vma has been already
> > +        * write-locked and readers can increment vm_refcnt only temporarily
> > +        * before they check vm_lock_seq, realize the vma is locked and drop
> > +        * back the vm_refcnt. That is a narrow window for observing a raised
> > +        * vm_refcnt.
> > +        */
> > +       if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
> > +               /* Wait until vma is detached with no readers. */
> > +               if (__vma_enter_locked(vma, true)) {
> > +                       bool detached;
> > +
> > +                       __vma_exit_locked(vma, &detached);
> > +                       WARN_ON_ONCE(!detached);
> > +               }
> > +       }
> > +}
> > +
> > +/*
> > + * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
> > + * stable and not isolated. If the VMA is not found or is being modified the
> > + * function returns NULL.
> > + */
> > +struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > +                                         unsigned long address)
> > +{
> > +       MA_STATE(mas, &mm->mm_mt, address, address);
> > +       struct vm_area_struct *vma;
> > +
> > +       rcu_read_lock();
> > +retry:
> > +       vma = mas_walk(&mas);
> > +       if (!vma)
> > +               goto inval;
> > +
> > +       vma = vma_start_read(mm, vma);
> > +       if (IS_ERR_OR_NULL(vma)) {
> > +               /* Check if the VMA got isolated after we found it */
> > +               if (PTR_ERR(vma) == -EAGAIN) {
> > +                       count_vm_vma_lock_event(VMA_LOCK_MISS);
> > +                       /* The area was replaced with another one */
> > +                       goto retry;
> > +               }
> > +
> > +               /* Failed to lock the VMA */
> > +               goto inval;
> > +       }
> > +       /*
> > +        * At this point, we have a stable reference to a VMA: The VMA is
> > +        * locked and we know it hasn't already been isolated.
> > +        * From here on, we can access the VMA without worrying about which
> > +        * fields are accessible for RCU readers.
> > +        */
> > +
> > +       /* Check if the vma we locked is the right one. */
> > +       if (unlikely(vma->vm_mm != mm ||
> > +                    address < vma->vm_start || address >= vma->vm_end))
> > +               goto inval_end_read;
> > +
> > +       rcu_read_unlock();
> > +       return vma;
> > +
> > +inval_end_read:
> > +       vma_end_read(vma);
> > +inval:
> > +       rcu_read_unlock();
> > +       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> > +       return NULL;
> > +}
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> > +#ifdef CONFIG_LOCK_MM_AND_FIND_VMA
> > +#include <linux/extable.h>
> > +
> > +static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
> > +{
> > +       if (likely(mmap_read_trylock(mm)))
> > +               return true;
> > +
> > +       if (regs && !user_mode(regs)) {
> > +               unsigned long ip = exception_ip(regs);
> > +               if (!search_exception_tables(ip))
> > +                       return false;
> > +       }
> > +
> > +       return !mmap_read_lock_killable(mm);
> > +}
> > +
> > +static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
> > +{
> > +       /*
> > +        * We don't have this operation yet.
> > +        *
> > +        * It should be easy enough to do: it's basically a
> > +V       *    atomic_long_try_cmpxchg_acquire()
> 
> Is the extra V above just the result of "Ctrl+V" gone bad?
> 
> > +        * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
> > +        * it also needs the proper lockdep magic etc.
> > +        */
> > +       return false;
> > +}
> > +
> > +static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
> > +{
> > +       mmap_read_unlock(mm);
> > +       if (regs && !user_mode(regs)) {
> > +               unsigned long ip = exception_ip(regs);
> > +               if (!search_exception_tables(ip))
> > +                       return false;
> > +       }
> > +       return !mmap_write_lock_killable(mm);
> > +}
> > +
> > +/*
> > + * Helper for page fault handling.
> > + *
> > + * This is kind of equivalent to "mmap_read_lock()" followed
> > + * by "find_extend_vma()", except it's a lot more careful about
> > + * the locking (and will drop the lock on failure).
> > + *
> > + * For example, if we have a kernel bug that causes a page
> > + * fault, we don't want to just use mmap_read_lock() to get
> > + * the mm lock, because that would deadlock if the bug were
> > + * to happen while we're holding the mm lock for writing.
> > + *
> > + * So this checks the exception tables on kernel faults in
> > + * order to only do this all for instructions that are actually
> > + * expected to fault.
> > + *
> > + * We can also actually take the mm lock for writing if we
> > + * need to extend the vma, which helps the VM layer a lot.
> > + */
> > +struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
> > +                       unsigned long addr, struct pt_regs *regs)
> > +{
> > +       struct vm_area_struct *vma;
> > +
> > +       if (!get_mmap_lock_carefully(mm, regs))
> > +               return NULL;
> > +
> > +       vma = find_vma(mm, addr);
> > +       if (likely(vma && (vma->vm_start <= addr)))
> > +               return vma;
> > +
> > +       /*
> > +        * Well, dang. We might still be successful, but only
> > +        * if we can extend a vma to do so.
> > +        */
> > +       if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
> > +               mmap_read_unlock(mm);
> > +               return NULL;
> > +       }
> > +
> > +       /*
> > +        * We can try to upgrade the mmap lock atomically,
> > +        * in which case we can continue to use the vma
> > +        * we already looked up.
> > +        *
> > +        * Otherwise we'll have to drop the mmap lock and
> > +        * re-take it, and also look up the vma again,
> > +        * re-checking it.
> > +        */
> > +       if (!mmap_upgrade_trylock(mm)) {
> > +               if (!upgrade_mmap_lock_carefully(mm, regs))
> > +                       return NULL;
> > +
> > +               vma = find_vma(mm, addr);
> > +               if (!vma)
> > +                       goto fail;
> > +               if (vma->vm_start <= addr)
> > +                       goto success;
> > +               if (!(vma->vm_flags & VM_GROWSDOWN))
> > +                       goto fail;
> > +       }
> > +
> > +       if (expand_stack_locked(vma, addr))
> > +               goto fail;
> > +
> > +success:
> > +       mmap_write_downgrade(mm);
> > +       return vma;
> > +
> > +fail:
> > +       mmap_write_unlock(mm);
> > +       return NULL;
> > +}
> > +#endif /* CONFIG_LOCK_MM_AND_FIND_VMA */
> > +
> > +#endif /* CONFIG_MMU */
> > --
> > 2.49.0
