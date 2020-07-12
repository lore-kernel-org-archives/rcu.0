Return-Path: <SRS0=XlIL=AX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8205EC433E2
	for <rcu@archiver.kernel.org>; Sun, 12 Jul 2020 16:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5872A2068F
	for <rcu@archiver.kernel.org>; Sun, 12 Jul 2020 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594570153;
	bh=IjxKA104PBTV6rYMTFQjKnY3pbyLHFYG4ujpSbcRzzM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FRpi48ifK/i2EQ/JRX8BBvB+6YRKBAaZWpd43ntAdr6caRMtb7g6A3TazZeX4nraK
	 T3/MgSdtd44mIRTiLndmEuo9eY8W4AMz77etnKB8Vv/WbfA8mCp/+zJkFVfP1c2X6d
	 NyC+lnHsJXCpkUDoGOIBIrD9u+pZdLrYq5ySCTTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgGLQI5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 12 Jul 2020 12:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgGLQI4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 12 Jul 2020 12:08:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3176820702;
        Sun, 12 Jul 2020 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594570136;
        bh=IjxKA104PBTV6rYMTFQjKnY3pbyLHFYG4ujpSbcRzzM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PP9B2G7OaMHY9x0QwoC8yRG5NYPF0b+HiNfn4yoO7QJL9aNOrpN3gVHmBDKGys1xj
         aFEB3n1dMxVoqWZTg74k6j+2i+MRjdavFrMwxE3fK+vpLilB/nP034ZbVqjts96dXK
         R6O9Lfaga6TGbp6+Wht6LXiZGWrEH0g8r4tPQ45g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1753E3522A6D; Sun, 12 Jul 2020 09:08:56 -0700 (PDT)
Date:   Sun, 12 Jul 2020 09:08:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     josh@joshtriplett.org, joel@joelfernandes.org, pbonzini@redhat.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        kvm@vger.kernel.org, frextrite@gmail.com
Subject: Re: [PATCH 2/2] kvm: mmu: page_track: Fix RCU list API usage
Message-ID: <20200712160856.GW9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200712131003.23271-1-madhuparnabhowmik10@gmail.com>
 <20200712131003.23271-2-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712131003.23271-2-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jul 12, 2020 at 06:40:03PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> Use hlist_for_each_entry_srcu() instead of hlist_for_each_entry_rcu()
> as it also checkes if the right lock is held.
> Using hlist_for_each_entry_rcu() with a condition argument will not
> report the cases where a SRCU protected list is traversed using
> rcu_read_lock(). Hence, use hlist_for_each_entry_srcu().
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

I queued both for testing and review, thank you!

In particular, this one needs an ack by the maintainer.

							Thanx, Paul

> ---
>  arch/x86/kvm/mmu/page_track.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> index a7bcde34d1f2..a9cd17625950 100644
> --- a/arch/x86/kvm/mmu/page_track.c
> +++ b/arch/x86/kvm/mmu/page_track.c
> @@ -229,7 +229,8 @@ void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
>  		return;
>  
>  	idx = srcu_read_lock(&head->track_srcu);
> -	hlist_for_each_entry_rcu(n, &head->track_notifier_list, node)
> +	hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
> +				srcu_read_lock_held(&head->track_srcu))
>  		if (n->track_write)
>  			n->track_write(vcpu, gpa, new, bytes, n);
>  	srcu_read_unlock(&head->track_srcu, idx);
> @@ -254,7 +255,8 @@ void kvm_page_track_flush_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
>  		return;
>  
>  	idx = srcu_read_lock(&head->track_srcu);
> -	hlist_for_each_entry_rcu(n, &head->track_notifier_list, node)
> +	hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
> +				srcu_read_lock_held(&head->track_srcu))
>  		if (n->track_flush_slot)
>  			n->track_flush_slot(kvm, slot, n);
>  	srcu_read_unlock(&head->track_srcu, idx);
> -- 
> 2.17.1
> 
