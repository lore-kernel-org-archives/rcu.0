Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500ECC2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3838020786
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDPVHn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbgDPVHn (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 17:07:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374AFC061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 14:07:43 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jPBjY-0006cd-BC; Thu, 16 Apr 2020 23:07:40 +0200
Date:   Thu, 16 Apr 2020 23:07:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416210740.qgu35fgsy6ar4iqg@linutronix.de>
References: <20200416160129.GA8337@pc636>
 <20200416161149.lkvkfwevanff36kb@linutronix.de>
 <20200416161819.GA8551@pc636>
 <20200416163302.3fsroillwk2om5dh@linutronix.de>
 <20200416172953.GR17661@paulmck-ThinkPad-P72>
 <20200416182309.zytrgowlngpewxbt@linutronix.de>
 <20200416182948.GV17661@paulmck-ThinkPad-P72>
 <20200416184348.GB149999@google.com>
 <20200416205636.fdljtricn6i3a2ub@linutronix.de>
 <20200416210424.GD176663@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416210424.GD176663@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-16 17:04:24 [-0400], Joel Fernandes wrote:
> Oh, ok! Thanks for the clarification and sorry about the noise. Now I get
> your motivation with the patch.

Don't worry. You might want to look over the documentation page I
pointed you earlier. It should cover everything I mentioned so far. And
please let us know if there is something missing / unclear in it.

> thanks,
> 
>  - Joel

Sebastian
