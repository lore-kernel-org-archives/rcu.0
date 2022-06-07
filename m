Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144A5C43334
	for <rcu@archiver.kernel.org>; Tue,  7 Jun 2022 03:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiFGDx1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Jun 2022 23:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiFGDxY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Jun 2022 23:53:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FDA36680
        for <rcu@vger.kernel.org>; Mon,  6 Jun 2022 20:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBB86B81C9F
        for <rcu@vger.kernel.org>; Tue,  7 Jun 2022 03:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DC5C34114;
        Tue,  7 Jun 2022 03:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654573999;
        bh=Pwl7m4+0iyRKzUmggeF/U82UqYcOL4unAVh/8RtSgZs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MiRbHaBoQ4vn8jn2K7jWokqY5q57DHaMuES3vc4rTj82/8HQQBfpzxJeRnQecslrB
         wQ1Qp5celgY14tfAMZIhEK9pqmOg0iGjyNX3ez6gAHV17CvcaS6H00P8Fqag45Cmh8
         RJ2OcT0igPsS/wHs70Z2A7tCa3gI5emFVVHLn3hieSmY2olwC71Pig/t015/EQBmZV
         3kLn0zcItsvRVO13uC1c/iUD+xrG08PzRj+yCpYfwkm/iBBbWuLukvIhMO4l2Ydxgp
         ml7btXFEDAsYK9FXR67dpZAx3uum+dJXVVyvx88WmIjuVBHqhm4iEokn0jZNx1WopY
         0dzRqlQ3nsnpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 25C125C05C5; Mon,  6 Jun 2022 20:53:19 -0700 (PDT)
Date:   Mon, 6 Jun 2022 20:53:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [Question] About rcu_nocb_poll bootargs
Message-ID: <20220607035319.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <PH0PR11MB58804878EF58CEB821D4C4ADDADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220602042004.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58803A844F44DA9B80FE4B2FDADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB58803A844F44DA9B80FE4B2FDADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 02, 2022 at 05:45:18AM +0000, Zhang, Qiang1 wrote:
> 
> On Thu, Jun 02, 2022 at 02:06:50AM +0000, Zhang, Qiang1 wrote:
> > Hi All
> > 
> > Currently, I have tested as follows:
> > 
> > runqemu kvm slirp nographic qemuparams="-m 2048 -smp 4"  
> > bootparams="isolcpus=2,3  nohz_full=2,3 rcu_nocbs=2,3 
> > rcutree.dump_tree=1, rcu_nocb_poll" -d
> > 
> > rcu:     Offload RCU callbacks from CPUs: 2-3.
> > rcu:     Poll for callbacks from no-CBs CPUs.
> > rcu: rcu_organize_nocb_kthreads: No-CB GP kthread CPU 0: 1   (rcuog/0)
> > rcu: rcu_organize_nocb_kthreads: No-CB GP kthread CPU 2: 3   (rcuog/2)
> > 
> > but I find the rt-fifo rcuog/0 kthreads always doing polling, but due 
> > to the my_rdp->nocb_head_rdp always is empty, this doesn't do the 
> > actual thing,  Is it possible that we do not polling when the nocb_head_rdp  linked list is empty, and polling when it is not empty.
> > 
> > Any thought?
> 
> >If I understand your question correctly, you would like to avoid polling when the rcuog kthread's CPU's rcu_data structure's nocb_head_rdp list is empty.  This could happen only when all of the CPUs served by that rcuog kthread have been de-offloaded, correct?
> 
> Yes, thanks Paul reply.  I'll be more careful with my wording next time.

不是问题！ 毕竟，情况可能会更糟。 我可能会尝试用中文或其他东西写作。

Et la langue dominante change avec le temps. Il n'y a pas si longtemps,
c'était le français plutôt que l'anglais. En tant qu'anglophone natif,
une partie de mon travail consiste à aider les locuteurs non natifs. Et
qui sait? Peut-être qu'un jour la langue dominante sera le chinois.

Yeah, Google Translate.  Why do you ask?  ;-)

> >If so, this is not currently a user-visible issue, but it would be good to fix it before offloading and de-offloading becomes user-visible.
> >
> >If this is what you were thinking, what did you have in mind for a fix?
> 
> When rcu_nocb_poll is set and the rcuog kthread's CPU's rcu_data structure's nocb_head_rdp list is empty, 
> treat rcuog kthread like non-polling mode and put them in the waitqueue(my_rdp->nocb_gp_wq) for waiting,
> when nocb_head_rdp list is not empty(rcu_nocb_poll && !list_empty(nocb_head_rdp)),  re-entering periodic wake-up mode. I need yours opinion.
> 
> Any thought?

This seems plausible to me!  This code is tricky, so it may take a time
or two to get it right, but what is life without a challenge?

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >(We need to get Frederic's view in any case, of course.)
> >
> >							Thanx, Paul
