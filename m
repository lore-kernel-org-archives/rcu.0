Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA6C4727E
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 16:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE89120848
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 16:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601569630;
	bh=5SJFWLlLE1Q0D2xnUTa3b82DRC5ltsPQ+3mNHhmvPXo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rhzbuRDDmg9LAAJ+eiYP6PGLVofqtn16yGhRVtorQvnLGBbxT+w+TnCLn28+5aJR5
	 cSyBLDXDmrUmnKEYX3eiovgYQA9YhanfUu6YQLBXPkK8irtKIdRf7CpJTlZpgLEIWx
	 Txz7MwbcrXN4FbF9Qe8Ov8PUJFdOfM7cF5kbiZP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgJAQ1K (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbgJAQ1K (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 12:27:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 492C420759;
        Thu,  1 Oct 2020 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601569629;
        bh=5SJFWLlLE1Q0D2xnUTa3b82DRC5ltsPQ+3mNHhmvPXo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XC9hZYxz1wGNkVbiMeeCEftD0moeRa7hVFXvFLAo2/rknRkFYt/9AHWGquNgoTV8g
         I4qZZVoqCtRh9Z5gWuepkGMpSHHxPw9I/+mc/TrDfBOSfj1rZ4sUAoLgS5K+C3jYfR
         A5hY93FackZd7M80Zn0OUUvDtwc8FjrkGd+5jTRA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0E1AB3522B33; Thu,  1 Oct 2020 09:27:09 -0700 (PDT)
Date:   Thu, 1 Oct 2020 09:27:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller
 is preemptible
Message-ID: <20201001162709.GD29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
 <20200930015327.GX29330@paulmck-ThinkPad-P72>
 <20200930084139.GN2277@dhcp22.suse.cz>
 <20200930232154.GA29330@paulmck-ThinkPad-P72>
 <20201001090220.GA22560@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001090220.GA22560@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 01, 2020 at 11:02:20AM +0200, Michal Hocko wrote:
> On Wed 30-09-20 16:21:54, Paul E. McKenney wrote:
> > On Wed, Sep 30, 2020 at 10:41:39AM +0200, Michal Hocko wrote:
> > > On Tue 29-09-20 18:53:27, Paul E. McKenney wrote:
> [...]
> > > > No argument on it being confusing, and I hope that the added header
> > > > comment helps.  But specifically, can_sleep==true is a promise by the
> > > > caller to be schedulable and not to be holding any lock/mutex/whatever
> > > > that might possibly be acquired by the memory allocator or by anything
> > > > else that the memory allocator might invoke, to your point, including
> > > > for but one example the reclaim logic.
> > > > 
> > > > The only way that can_sleep==true is if this function was invoked due
> > > > to a call to single-argument kvfree_rcu(), which must be schedulable
> > > > because its fallback is to invoke synchronize_rcu().
> > > 
> > > OK. I have to say that it is still not clear to me whether this call
> > > path can be called from the memory reclaim context. If yes then you need
> > > __GFP_NOMEMALLOC as well.
> > 
> > Right now the restriction is that single-argument (AKA can_sleep==true)
> > kvfree_rcu() cannot be invoked from memory reclaim context.
> > 
> > But would adding __GFP_NOMEMALLOC to the can_sleep==true GFP_ flags
> > allow us to remove this restriction?  If so, I will queue a separate
> > patch making this change.  The improved ease of use would be well
> > worth it, if I understand correctly (ha!!!).
> 
> It would be quite daring to claim it will be ok but it will certainly be
> less problematic. Adding the flag will not hurt in any case. As this is
> a shared called that might be called from many contexts I think it will
> be safer to have it there. The justification is that it will prevent
> consumption of memory reserves from MEMALLOC contexts.

Ah, so a different goal (and yes, I finally went over and read the
relevant documentation).  Agreed, the can_sleep path does not really
need to be dipping into the emergency reserves.  And it looks like the
not-from-reclaim restriction is still at least partially in effect,
but one step at a time.

The patch is shown below, which I have queued for a later release.

> > > [...]
> > > 
> > > > > What is the point of calling kmalloc  for a PAGE_SIZE object? Wouldn't
> > > > > using the page allocator directly be better?
> > > > 
> > > > Well, you guys gave me considerable heat about abusing internal allocator
> > > > interfaces, and kmalloc() and kfree() seem to be about as non-internal
> > > > as you can get and still be invoking the allocator.  ;-)
> > > 
> > > alloc_pages resp. __get_free_pages is a normal page allocator interface
> > > to use for page size granular allocations. kmalloc is for more fine
> > > grained allocations.
> > 
> > OK, in the short term, both work, but I have queued a separate patch
> > making this change and recording the tradeoffs.  This is not yet a
> > promise to push this patch, but it is a promise not to lose this part
> > of the picture.  Please see below.
> 
> It doesn't matter all that much. Both allocators will work. It is just a
> matter of using optimal tool for the specific purose.
> 
> > You mentioned alloc_pages().  I reverted to __get_free_pages(), but
> > alloc_pages() of course looks nicer.  What are the tradeoffs between
> > __get_free_pages() and alloc_pages()?
> 
> alloc_pages will return struct page but you need a kernel pointer. That
> is what __get_free_pages will give you (or you can call page_address
> directly).

Thank you, looks like __get_free_pages() is the tool for this job.

Please see below for the aforementioned patch.

							Thanx, Paul

------------------------------------------------------------------------

commit ea5c19d21233b5e8d3d06c0d4ecd6be9f2829dc3
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Oct 1 09:24:40 2020 -0700

    kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
    
    This commit applies the __GFP_NOMEMALLOC gfp flag to memory allocations
    carried out by the single-argument variant of kvfree_rcu(), thus avoiding
    this can-sleep code path from dipping into the emergency reserves.
    
    Suggested-by: Michal Hocko <mhocko@suse.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 242f0f0..6132452 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3364,7 +3364,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 {
 	struct kvfree_rcu_bulk_data *bnode;
 	bool can_alloc_page = preemptible();
-	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;
+	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC
+			       : GFP_ATOMIC) | __GFP_NOWARN;
 	int idx;
 
 	*krcp = krc_this_cpu_lock(flags);
