Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92504C433F5
	for <rcu@archiver.kernel.org>; Thu,  7 Apr 2022 15:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbiDGPSO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344511AbiDGPSM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Apr 2022 11:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1431FAA14
        for <rcu@vger.kernel.org>; Thu,  7 Apr 2022 08:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21C061DF4
        for <rcu@vger.kernel.org>; Thu,  7 Apr 2022 15:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025BBC385A0;
        Thu,  7 Apr 2022 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649344556;
        bh=zgcypSqcOjttw+NOmBx1xs+dR2yyEnA+Y3BOWHLvyQg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=b7AdTEGUiOsYfaURI5xgXgpBRMlEDu/XqqCHGRYGQLlEJnQ2HcZ4jNAS7et+QhRui
         oJqBT1w3IB/PENacBAqj/hm337U60JTOWVvmvcYULxFIxMUapuv18NsrDA3Y80muwE
         yTPSIObBOyYIlTUim8dgGHhwU50dqc8aDhPrp5NlcMSXZAmTQF2R7tYS/ERO9zO1vT
         E5uyt5JWxB/Sc2aVUXIWeb0F5xsP5dl7Et83ftsQD4sN+mC3UpuJRRag7SsCxtDjdA
         S/UoGWuvhzpzvevLesnGY1A3yWPoorCbIWsVBUXsyqV8EIo5U6wwrKJ0Kwq+PPe1fq
         bJm3DYzh399dw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 14F165C0176; Thu,  7 Apr 2022 08:15:55 -0700 (PDT)
Date:   Thu, 7 Apr 2022 08:15:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: rcu_sched self-detected stall on CPU
Message-ID: <20220407151555.GR4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zhZaN0+KqP7oMoyXTSkDhLjZwWvnj7coa1ZVve9M+jsQ@mail.gmail.com>
 <20220406195011.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x8_783jhEhC3AozH9=xj40UO-rZT2BRJsg5gaLdBz=9w@mail.gmail.com>
 <CANiq72mYXnQo_Y39k23rY-rdJay8GEPJ8MhU-y7-bjkw=zRC+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mYXnQo_Y39k23rY-rdJay8GEPJ8MhU-y7-bjkw=zRC+Q@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 07, 2022 at 12:07:34PM +0200, Miguel Ojeda wrote:
> On Thu, Apr 7, 2022 at 4:27 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > Yes, this happens within 30 seconds after kernel boot.  If we take all
> > into account (qemu preparing, kernel loading), we can do one test
> > within 54 seconds.
> 
> When it does not trigger, the run should be 20 seconds quicker than
> that (e.g. 10 seconds), since we don't wait for the stall timeout. I
> guess the timeout could also be reduced a fair bit to make failures
> quicker, but they do not contribute as much as the successes anyway.

Ah.  So you would instead look for boot to have completed within 10
seconds?  Either way, reliable automation might well more important than
reduction in time.

> Thanks a lot for running the bisect on that server, Zhouyi!

What Miguel said!

							Thanx, Paul
