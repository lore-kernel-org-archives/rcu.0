Return-Path: <SRS0=sYuw=TD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5648FC43219
	for <rcu@archiver.kernel.org>; Fri,  3 May 2019 07:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335B7208C3
	for <rcu@archiver.kernel.org>; Fri,  3 May 2019 07:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfECH0y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 May 2019 03:26:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfECH0y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 May 2019 03:26:54 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hMSao-0006xT-AI; Fri, 03 May 2019 09:26:50 +0200
Date:   Fri, 3 May 2019 09:26:50 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] rcutorture: Tweak kvm options
Message-ID: <20190503072649.g45a4k27fnzlmz3y@linutronix.de>
References: <20190424073446.8577-1-bigeasy@linutronix.de>
 <20190424103809.GM3923@linux.ibm.com>
 <20190424183039.GA4494@linux.ibm.com>
 <20190425194638.GA7238@linux.ibm.com>
 <20190426105413.rajcon4vyzov446c@linutronix.de>
 <20190426135058.GD3923@linux.ibm.com>
 <20190429081943.gucbalncrrttxxcr@linutronix.de>
 <20190429144924.GP3923@linux.ibm.com>
 <20190429150600.GA14389@linux.ibm.com>
 <20190502184116.GA8811@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190502184116.GA8811@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2019-05-02 11:41:16 [-0700], Paul E. McKenney wrote:
> And I ended up with the following variant of your patch.  If I don't
> hear otherwise from you, I will assume that you are OK with it.  So if
> something bothers you about it, please don't suffer in silence!

perfect, thank you!

> 							Thanx, Paul

Sebastian
