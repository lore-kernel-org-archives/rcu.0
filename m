Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB6C433EF
	for <rcu@archiver.kernel.org>; Thu, 21 Apr 2022 12:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386368AbiDUMxn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386366AbiDUMxn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Apr 2022 08:53:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E132993;
        Thu, 21 Apr 2022 05:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C79F2B82293;
        Thu, 21 Apr 2022 12:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE6C385A1;
        Thu, 21 Apr 2022 12:50:49 +0000 (UTC)
Date:   Thu, 21 Apr 2022 08:50:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     patrick wang <patrick.wang.shcn@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: ftrace: avoid tracing a few functions executed in
 multi_cpu_stop()
Message-ID: <20220421085047.2cb8edf9@gandalf.local.home>
In-Reply-To: <CAGcnep86pd2trfTovU8_z1msOstx7gKCdndm=pHLDGTy+_K7=g@mail.gmail.com>
References: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
        <20220418143404.55c8fcab@gandalf.local.home>
        <CAGcnep8bH4Nncbt3t+VRLff35ZyD8JyzHcEgkq-u6TEq47jqzQ@mail.gmail.com>
        <CAGcnep_Gx+3KiUvDVronYKn_divU3OM-RQEOPZakv7MRYh4EJw@mail.gmail.com>
        <20220420114454.69ab108c@gandalf.local.home>
        <20220420122633.55d4ff6b@gandalf.local.home>
        <CAGcnep86pd2trfTovU8_z1msOstx7gKCdndm=pHLDGTy+_K7=g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 21 Apr 2022 19:36:06 +0800
patrick wang <patrick.wang.shcn@gmail.com> wrote:

> On Thu, Apr 21, 2022 at 12:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 20 Apr 2022 11:44:54 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > Interesting. On x86 when we used stop machine[*] it was not an issue to
> > modify the code that is being executed in stop machine. I'm curious to
> > exactly what the issue is if something does get traced in the stop machine
> > processing. Why does it crash?  
> 
> I looked up the commit history. When x86 turned to breakpoints, stop
> machine's state machine loop had no calls during waiting. So there
> was no function being called during modifying code. Which means
> there were no other cpus would load those instructions to be updated
> in this period. While the stop machine currently will call other functions
> and the call chain is fairly deep. So it may not quite be suitable for ftrace
> now because it can not make sure the instructions within its own call
> chain are updated atomically.

Are you saying that the RISC-V stop machine implementation has code being
called on the other CPUs while they wait?

-- Steve
