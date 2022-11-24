Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C0EC4332F
	for <rcu@archiver.kernel.org>; Thu, 24 Nov 2022 00:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKXAVd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 19:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXAVc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 19:21:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F6623A5
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 16:21:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6B1AB825F6
        for <rcu@vger.kernel.org>; Thu, 24 Nov 2022 00:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D35C433D6;
        Thu, 24 Nov 2022 00:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669249288;
        bh=F3nMEi0/i23+ohAwW+IoOB0q23o7kJvxyk3gcIy48pg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hTHXTa38fBEMgnrdbNfR3lwhFxgIdzGuup/bH+PX+mq0HfApjBIWs3kaALRNJoIRw
         q04T7jBS4qSH5yjmdHMokvVyL4bGUf4N68MinSdwqyVtY+7hr7oYYEBPRBywnTSLv+
         ThwnF3BJ7sISmwNx4RM7Zf7yf8tBLtbP4ekmE5F5YreNvnamX96nRyyptVlapSm/WH
         MZkl1htk+AiKwcPHQi4FInnxoEh27YUM8W/qu/Md4fDnHsfl4AkM5p2FTmIztelpxp
         FUb246/mMh8dKX96ULyEPrxCF+xqY+RA2wcw7MhtNF/LR1ti97ycCtyggXuQYbhUiN
         f4lpgSkPWvigw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 09C4B5C0DF2; Wed, 23 Nov 2022 16:21:28 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:21:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: SRCU use from different contexts
Message-ID: <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221123114645.3aowv3hw4hxqr2ed@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123114645.3aowv3hw4hxqr2ed@quack3>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 23, 2022 at 12:46:45PM +0100, Jan Kara wrote:
> Hello!
> 
> We were pondering with Amir about some issues with fsnotify subsystem and
> as a building block we would need a mechanism to make sure write(2) has
> completed. For simplicity we could imagine it like a sequence
> 
> write(2)
>   START
>   do stuff to perform write
>   END
> 
> and we need a mechanism to wait for all processes that already passed START
> to reach END. Ideally without blocking new writes while we wait for the
> pending ones. Now this seems like a good task for SRCU. We could do:
> 
> write(2)
>   srcu_read_lock(&sb->s_write_rcu);
>   do stuff to perform write
>   srcu_read_unlock(&sb->s_write_rcu);
> 
> and use synchronize_srcu(&sb->s_write_rcu) for waiting.
> 
> But the trouble with writes is there are things like aio or io_uring where
> the part with srcu_read_lock() happens from one task (the submitter) while
> the part with srcu_read_unlock() happens from another context (usually worker
> thread triggered by IRQ reporting that the HW has finished the IO).
> 
> Is there any chance to make SRCU work in a situation like this? It seems to
> me in principle it should be possible to make this work but maybe there are
> some implementation constraints I'm missing... 

The srcu_read_lock_notrace() and srcu_read_unlock_notrace() functions
will work for this, though that is not their intended purpose.  Plus you
might want to trace these functions, which, as their names indicate, is
not permitted.  I assume that you do not intend to use these functions
from NMI handlers, though that really could be accommodated.  (But why
would you need that?)

So how about srcu_down_read() and srcu_up_read(), as shown in the
(untested) patch below?

Note that you do still need to pass the return value from srcu_down_read()
into srcu_up_read().  I am guessing that io_uring has a convenient place
that this value can be placed.  No idea about aio.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 0efa1e7b5a862e9c2f1bf8c19db6bd142ad35355
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Nov 23 15:49:55 2022 -0800

    rcu: Add srcu_down_read() and srcu_up_read()
    
    A pair of matching srcu_read_lock() and srcu_read_unlock() invocations
    must take place within the same context, for example, within the same
    task.  Otherwise, lockdep complains, as is the right thing to do for
    most use cases.
    
    However, there are use cases involving asynchronous I/O where the
    SRCU reader needs to begin on one task and end on another.  This commit
    therefore supplies the semaphore-like srcu_down_read() and srcu_up_read(),
    which act like srcu_read_lock() and srcu_read_unlock(), but permitting
    srcu_up_read() to be invoked in a different context than was the matching
    srcu_down_read().
    
    Neither srcu_down_read() nor srcu_up_read() may be invoked from an
    NMI handler.
    
    Reported-by: Jan Kara <jack@suse.cz>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 9b9d0bbf1d3cf..74796cd7e7a9d 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -214,6 +214,34 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 	return retval;
 }
 
+/**
+ * srcu_down_read - register a new reader for an SRCU-protected structure.
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * Enter a semaphore-like SRCU read-side critical section.  Note that
+ * SRCU read-side critical sections may be nested.  However, it is
+ * illegal to call anything that waits on an SRCU grace period for the
+ * same srcu_struct, whether directly or indirectly.  Please note that
+ * one way to indirectly wait on an SRCU grace period is to acquire
+ * a mutex that is held elsewhere while calling synchronize_srcu() or
+ * synchronize_srcu_expedited().  But if you want lockdep to help you
+ * keep this stuff straight, you should instead use srcu_read_lock().
+ *
+ * The semaphore-like nature of srcu_down_read() means that the matching
+ * srcu_up_read() can be invoked from some other context, for example,
+ * from some other task or from an irq handler.  However, neither
+ * srcu_down_read() nor srcu_up_read() may be invoked from an NMI handler.
+ *
+ * Calls to srcu_down_read() may be nested, similar to the manner in
+ * which calls to down_read() may be nested.
+ */
+static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
+{
+	WARN_ON_ONCE(in_nmi());
+	srcu_check_nmi_safety(ssp, false);
+	return __srcu_read_lock(ssp);
+}
+
 /**
  * srcu_read_unlock - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
@@ -254,6 +282,23 @@ srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
 	__srcu_read_unlock(ssp, idx);
 }
 
+/**
+ * srcu_up_read - unregister a old reader from an SRCU-protected structure.
+ * @ssp: srcu_struct in which to unregister the old reader.
+ * @idx: return value from corresponding srcu_read_lock().
+ *
+ * Exit an SRCU read-side critical section, but not necessarily from
+ * the same context as the maching srcu_down_read().
+ */
+static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
+	__releases(ssp)
+{
+	WARN_ON_ONCE(idx & ~0x1);
+	WARN_ON_ONCE(in_nmi());
+	srcu_check_nmi_safety(ssp, false);
+	__srcu_read_unlock(ssp, idx);
+}
+
 /**
  * smp_mb__after_srcu_read_unlock - ensure full ordering after srcu_read_unlock
  *
