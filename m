Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED015CCA47B
	for <rcu@archiver.kernel.org>; Thu,  2 Jun 2022 04:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiFBEUO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jun 2022 00:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiFBEUH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jun 2022 00:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F65EDDD
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 21:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50FAC616C4
        for <rcu@vger.kernel.org>; Thu,  2 Jun 2022 04:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82A2C385A5;
        Thu,  2 Jun 2022 04:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654143604;
        bh=oDGxOeMnShkqBTndzPkflUe34E0qdsri+zr6t8rqdbE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K+gonRorsPW5hI2Ijr96wE33Clp5nUdQh+J4BCHoVuXbdjurSP2i4uF68Y6GOZBYy
         IIUBl2QTW2qf+57AlbAEhkTx3nrhGNmWY7cF67qAy2VOJEvg3nVpY9YdEGDaRthunE
         oXOYpa6D1G6SAWCOdMxDPvdw88z1pUpkDUPUb/Fjf6wHMAVhYJC6GQyzTfPdcu7x72
         Efsrq4zaULuqezAlixTAV033LxTNm0hDPVbcC9LVrzsoJxGdpCeEIV8qBhbX901bHo
         8OuCK3i5BIGBxaF9FhF4K5+VU0es/XU4xD3IBkmn25SyiA9XxozVvi2sB5ywUnn8zi
         WcS30osl9nAVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 484155C014C; Wed,  1 Jun 2022 21:20:04 -0700 (PDT)
Date:   Wed, 1 Jun 2022 21:20:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [Question] About rcu_nocb_poll bootargs
Message-ID: <20220602042004.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <PH0PR11MB58804878EF58CEB821D4C4ADDADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58804878EF58CEB821D4C4ADDADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 02, 2022 at 02:06:50AM +0000, Zhang, Qiang1 wrote:
> Hi All
> 
> Currently, I have tested as follows:
> 
> runqemu kvm slirp nographic qemuparams="-m 2048 -smp 4"  bootparams="isolcpus=2,3  nohz_full=2,3 rcu_nocbs=2,3 rcutree.dump_tree=1, rcu_nocb_poll" -d
> 
> rcu:     Offload RCU callbacks from CPUs: 2-3.
> rcu:     Poll for callbacks from no-CBs CPUs.
> rcu: rcu_organize_nocb_kthreads: No-CB GP kthread CPU 0: 1   (rcuog/0)
> rcu: rcu_organize_nocb_kthreads: No-CB GP kthread CPU 2: 3   (rcuog/2)
> 
> but I find the rt-fifo rcuog/0 kthreads always doing polling, but due to the my_rdp->nocb_head_rdp always is empty,
> this doesn't do the actual thing,  Is it possible that we do not polling when the nocb_head_rdp  linked list is empty, 
> and polling when it is not empty.
> 
> Any thought?

If I understand your question correctly, you would like to avoid polling
when the rcuog kthread's CPU's rcu_data structure's nocb_head_rdp list
is empty.  This could happen only when all of the CPUs served by that
rcuog kthread have been de-offloaded, correct?

If so, this is not currently a user-visible issue, but it would be good
to fix it before offloading and de-offloading becomes user-visible.

If this is what you were thinking, what did you have in mind for a fix?

(We need to get Frederic's view in any case, of course.)

							Thanx, Paul
