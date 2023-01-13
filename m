Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D268CC6379F
	for <rcu@archiver.kernel.org>; Fri, 13 Jan 2023 21:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjAMVgy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjAMVgw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Jan 2023 16:36:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F2288DE3
        for <rcu@vger.kernel.org>; Fri, 13 Jan 2023 13:36:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E881CB821F5
        for <rcu@vger.kernel.org>; Fri, 13 Jan 2023 21:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76755C433F1;
        Fri, 13 Jan 2023 21:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673645806;
        bh=paFuRiBnlPPIeTHNiweTEtPsfNV/HzK2CLo9MmKieqw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TCLodBsvNL7DoOVCMChoGWkaJJJfefmpGZ3JU6sqJzCiiHx9JHK/I4BALsDPVocFv
         JJ6FYm4SIHGxIv1rVWW1RnSuRIUL+b6dbAgj7Wa+5zTiS838PUwt+Q01ZfY4IBV1ll
         QWmP2atEK/8dwiUbUL15Voe4mmby0u3FKhMLsjdQCmwCFz0SKzHQcE9mAdAOQI4BAi
         34B955D/x6GMxCMaYcK4usU6/TSQMUs0cKBvREos4BC5jC/VqPiXLNh2ifApmyAozT
         qUUabWs2/FRDbGdPmhiHjOMDysLnt3ZLT2XT72B/OnhnR4MAHVcKYextLeo4rlTwgz
         +7+NVAG8R6wIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0B5925C06D0; Fri, 13 Jan 2023 13:36:46 -0800 (PST)
Date:   Fri, 13 Jan 2023 13:36:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     rcu@vger.kernel.org, quic_neeraju@quicinc.com
Subject: Re: Diagnosing stall in synchronize_srcu() from rcu_tasks_postscan()
Message-ID: <20230113213646.GJ4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230111212736.GA1062057@paulmck-ThinkPad-P17-Gen-1>
 <Y8HFi/4kGc7gSAL0@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8HFi/4kGc7gSAL0@sirena.org.uk>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 13, 2023 at 08:56:43PM +0000, Mark Brown wrote:
> On Wed, Jan 11, 2023 at 01:27:36PM -0800, Paul E. McKenney wrote:
> > Hello, Mark,
> > 
> > A few days ago you mentioned stalls in RCU tasks.  Neeraj has supplied
> > the following diagnostic patch, which will confirm or invalidate my
> > assumptions about the cause of the stall.
> > 
> > Could you please try it out and let us know the outcome?
> 
> As I mentioned the other day I'm having trouble getting anything I build
> to show the problem, I'm noticing it only for jobs submitted by KernelCI
> to my test lab.  I'm still poking at it a bit, and trying to persuade
> the automation to process the branch I have which should be able to
> trigger on random commits which would hopefully also let me trigger
> things that way, but at the minute anything I build myself appears to
> run fine even when I try to use the same toolchain and so on.

OK, apologies for the noise!  It will hit mainline at some point, and
then the KernelCI folks will have to work to avoid it.  ;-)

							Thanx, Paul
