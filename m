Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D15C433EF
	for <rcu@archiver.kernel.org>; Tue, 10 May 2022 14:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbiEJOt0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 May 2022 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243715AbiEJOtS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 May 2022 10:49:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79056B64B;
        Tue, 10 May 2022 07:07:26 -0700 (PDT)
Date:   Tue, 10 May 2022 16:07:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652191644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qp86ef6p5o8Z9WJ28fFoveIPXYESjGYCHVxJ1LH2/ww=;
        b=TnZA5rMH9fkLa02hqnOk+0Yqfaq2LKfb4e3U1oZSY1Kr7doRf2hHz6wykzhWXHsLUkWXdU
        OtuiR3p9gyoDcpYTwY9o4p3TtnbRw/jTfuSfQ2fwu4nTwYrOvkx6ydv58NntWaNPbpxAuA
        xW3C+Ppep8t74EyDThw7O4z6+JOjBVVh+9Wvt/C4gOPFjdbeY+hqNS4xwMzMUav3jYD7er
        zkTQATMivcXMRgOF2GKzKt554a+pnrbL88+5jJF91YuTN2FRbnJ3j+Y2MLff3f2EUWr6Vf
        gpMROdGq0Mk0bel668pOCh9t3vpMHjANKcQOWirZ/K1ZnMwXZsbQKfgJZ55Obw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652191644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qp86ef6p5o8Z9WJ28fFoveIPXYESjGYCHVxJ1LH2/ww=;
        b=ohnqgtsZZrLb/ZNCVxwurcS9YlaHFk1BUYJkMn9dhbO+R0QW4tj//lxVCL6tBQ058c1iX7
        iEuXYN07glaWEgDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <Ynpxm46hEg0+G82g@linutronix.de>
References: <20220505101641.28472-1-urezki@gmail.com>
 <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-05-05 12:09:15 [-0700], Paul E. McKenney wrote:
> All good points!
>=20
> Some questions and comments below.
>=20
> Adding Sebastian on CC for his perspective.

Thank you.
I may missing things, I tried to digest the thread=E2=80=A6

In my understanding: The boosting option is used to allow a SCHED_OTHER
task within a RCU section to allow to leave the RCU section while tasks
with higher priority occupy the CPU.
As far as the RCU callbacks are concerned, I'm not aware that it would
be beneficial to run them with an elevated priority. On SMP systems,
there is the suggestion to have a housekeeping CPU and to offload the
RCU callbacks to this CPU and no to bother the CPU with the RT workload.

> 						Thanx, Paul

Sebastian
