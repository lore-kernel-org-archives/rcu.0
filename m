Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE8C2BBCA
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C728224D2
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLOORm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:17:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgLOORj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Dec 2020 09:17:39 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608041816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7aQCRMYg359XANmIm4umzDdgT0KHm4PaT2cIWvw+iys=;
        b=d3bLod4vrx9ToLJZVvNsSCrg7E038h952jSVJl21dcCkMTn67avYSR+AiPtv+1TqEIbg7T
        9M8I/i7ewIG8xRLGQgo9vqXr3/JPlNsZLNyKoleE/kkLuvNy40S7uyIheXLDxhrmaelrhw
        zI+ij6npSnQiZ+PA0gGxpcFKALkbyTbthnYyvbarqEfss6ds+7VKqIekgaP/rGZfWjZnNU
        FV9JfaXiyVnj9Xw4RZl9Qz+5/PVBIoFjWlqJrCKFAHvtPQAtQsC/yDq9+/e5ViWAw1TQLO
        iDQujtKKT2ljqIWUOu5nrsZvnzBEzlP/xQYV6zKK+iS9EQZb1BvXTYMvqyvQNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608041816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7aQCRMYg359XANmIm4umzDdgT0KHm4PaT2cIWvw+iys=;
        b=ecwl9JrvRg15pTWFoYs8NLzScDi3I5hpuRAOj4OTXPwgh3i0Mhy/zyo6uEXv/l+eNCKG0C
        AR7IMVMyYRBTKJDg==
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/5] A few smaller RCU related patches from the RT tree
Date:   Tue, 15 Dec 2020 15:16:44 +0100
Message-Id: <20201215141649.796472-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

I know the timming of this regarding the merge window is bad. I meant to
send them for days=E2=80=A6

Initially I planned to send only 5/5 of the series but then I stumbled
upon the other RCU related patches and I don't see a reason I shouldn't
post them.
I still have one patch regarding rcutorture which I hold on to until the
current issues are resolved (in case you are curious: Scott made sure BH
can disabled properly in atomic context on RT (while keeping this
limitation to RT only builds). The current softirq implementation does
not allow to disable BH in atomic context).

Sebastian


