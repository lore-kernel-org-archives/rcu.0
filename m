Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749389;
	b=LG5eSUFpHIbAIdOGny4VWNLqtSqgbIL9LrHSJfJKsJX1Ld3L30Ov96tdDPZML6a1UNmk
	 x8spli4cAw/i1O56/qv/503sKUZb3x4Xqemjy6WV6O0vzz+j9+/gHVgphVcZXeCy+1HXh
	 4jvQFBfM4Xow212+Oa08KC45VRYGyZ4mQFHoM2g1fQ5ZK65qF5EWZE5GbBirnYQi0UK8w
	 +Ej3I1gyBG0qqEyTsddDbv/DJjKojEgQ22O7NkMe7Z4xxY37sl0ZgZAu+uq1i7iKrgH7J
	 YF6eFI9iSB8WckHWOYPb7VvJZAG9ZaetJg7tKsrJzP5KUfpUadH+RLph7ZKFYZiwFpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0TmtvtXPpRF/twzDdIfwnX1S+VDt4Q6vGLAqJtu7vYk=;
	b=1u0KsH/6LoVaZRgFsTjeabiJ2w6U0oIjofN4CUwFoV28q0C8mPZirBr2SapXJC4T0WIR
	 FpbjV56hzgKISR+5I9T/cd5uzpEdeQUkq2eUFEnKedZhDkRp/xByg0bEAFbWyN//pS9dR
	 Gv+9BtCXSzAUmjKv2WkAHhqI947/IAYHiuVcgeAYsAYr80/d6eVB2AC/aYrcFysTx+dv2
	 J1hX5o7+VrlicuiKB27m7arzgvqLWdlsXcGhgjZmnQ7JWhD0mdt1iEZlB6GSx0Lbc6B+/
	 EijojopFBilRiCXuoHo+HZ6kirMz2oZQjzGpfyDnLNGK7iA/q2KZBJnZ/HC+SHTV9bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnm0mtJq;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8CB606A326
	for <rcu@vger.kernel.org>; Tue,  3 Nov 2026 23:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC8CB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnm0mtJq
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso40796f8f.1
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 15:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749382; x=1794354182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0TmtvtXPpRF/twzDdIfwnX1S+VDt4Q6vGLAqJtu7vYk=;
        b=xnm0mtJqbkB7h9G/6sIwfu/wmAnSeVK4enwhz/WVKNoVuQp3IXNXsfreEKy1/hnXAl
         oY3vXQvLDc5pOa7HK2xN5Htaruz26zZILXsP8MB67nIkqEHNYoueUUfbWeSoILXPYpSj
         WgIKEe29QnHb0cdxpuhMfmYQpIP0TnHfiiryfOhpApkV4tiKQv3pDmmReJgd6Vj8VaDh
         f7z3oycGwnUI/D/c9eZqZYceICv97qEPY0NnVFcAjs1Y9sqDmR3sStammSKeg/xbmUMJ
         Gcjxv8ZfDiSasLpwfEFptU3qeFg31AGuIflLx6HnMyCf3VioZ4/dbCMizx3NTo5YOVJL
         bvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749382; x=1794354182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0TmtvtXPpRF/twzDdIfwnX1S+VDt4Q6vGLAqJtu7vYk=;
        b=ft+kCESxy5t84JMoaeh62+Ws6/274akJqEzpoCKUzxnwNhkYTwLIXx/ywP2dEuz4WW
         QJBTKm2MjDYifE/ogUbk4j5a2fjyxneE3/pfkEQ2/GY8YJbO4gl1iRqcPF7tHJcjhs6y
         IWnikkNfTbubTWSZPISvjmMha1rSntEtEwMYAxBflelroFUeBxQgSA6LPuThVlP+PPr5
         fq6ac4MTA28XqnOPf3nTI+fBpx5iDRl4VQFiBrM3kOkWdj1HYUqK1c2xNotbNfgl0tTE
         9Am+Gyea9ktWWY0AXsFhulYOKmYZ8OzZqvv8pNdCXZ4i53U8BxB1hcbRcMl5CW81GBuv
         O1Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxl9irAYMq5sHroOQdpF1NeY8f3GAn5hs5b6Zk7JFu84t+d5h6e+dJ3grWiwEKOarONN6c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/drK419JTr5yytwwtES/h8S6vcaRtwY3znUa6uuWsPjhLctOa6
	8KiU0Xn6e/BwyG+m7Pzllw46MIGEgtmJBPqBEA7m02yqH86pD5k5WBoe
X-Gm-Gg: AYBFou0eMnskr888PCxcyqM+ZI9qOrZfWw1/BTJT01Q9J/yNqTsxuUWda94I6oWsVBN
	qub1KLVopgIWhrdwGVzO3O2N+hV/GOfCJrppd9+1vcdCmx31eh4BTYT7jvrdbDm2rcbAFsPl+/V
	MVnKQtE+gAJK6NYT2TFlI4XPlNH5lhHCsDWrjFWlGCVO9NwhzatmpR6kdmYN4V75YZ2xtNQr2x2
	zpvhIX6a+V6w6g1MLhtFrMLObKRTKDY/C5QD5TokOCD2LtOgfA3lLJyZ4GPpNsjpJvuaSsYGXIZ
	Al2VLsLzqn1rkPVO/Xton27bSLVrESi7fO87x9Lori0OYi0WyOpfK/9HFLpHV/IYhOYrxSZG69N
	zoQgTbcLBd/ZWfTb8ZOiRxsCPyhMf9yGpI9Kvi63cCbK9X72TLQxyatGQ9PndzSWnOeRmqbO/rw
	yrKX2lZhl08hbbKy+32PmqASavpV//gvu7XUar6S5582O8DWZydnUwojXBDcXZj05m+Q6za8n2I
	HtQW5CFrJ556u5GJn+bdSrLRoUQ5ny6+NNOdYTYiKFUqKs4CcUI8YJAjC/hYB1dV1BsS1JqJ+/w
	r4PR95cpk3ar6daWktC2mMJKrY34mS1vibibgEaep2HlWxcUXT/EoxHMw1WguRO4xhn4yuQoLw1
	9LQ==
X-Received: by 2002:a5d:4d82:0:b0:48b:a21:87f7 with SMTP id ffacd0b85a97d-48e6e4f4ff5mr25016512f8f.44.1793749381829;
        Tue, 03 Nov 2026 15:43:01 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1f100sm513060f8f.46.2026.11.03.15.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:01 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu/dev 1/4] hazptrtorture: Release all deferred hazard pointers before stopping
Date: Wed,  4 Nov 2026 00:42:41 +0100
Message-ID: <20261103234246.2546810-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ad753ec5-52ee-4fcf-8275-77095f42e8c9@paulmck-laptop>
References: <20261027163811.2470569-1-parri.andrea@gmail.com> <20261027163811.2470569-2-parri.andrea@gmail.com> <eb59edbb-c6e8-49c6-a426-c55cdb792853@paulmck-laptop> <9da03ed6-fea2-44df-8aee-f7a61a1d35ce@paulmck-laptop> <178eaa0b-e7bd-455e-ac3c-f1115d731a52@paulmck-laptop> <20261103190507.1913628-1-parri.andrea@gmail.com> <ad753ec5-52ee-4fcf-8275-77095f42e8c9@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 12:44:07PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 03, 2026 at 08:05:06PM +0100, Andrea Parri wrote:

[...]

> > >     hazptr_torture_cleanup() stops the kthreads in random order, which
> >
> > The order is fixed: do_pending, preempt, the writer, then the readers.
>
> That was my first thought, but then I remembered that torture_init_begin()
> sets fullstop to FULLSTOP_DONTSTOP, which causes torture_must_stop()
> to return true, thus stopping all the hazptrtorture kthread at about
> the same time in some random order.
>
> By the time hazptr_torture_cleanup() gets around to invoking
> torture_stop_kthread() for the various kthreads, the game is up.

torture_must_stop() does become true for all the kthreads at once,
when torture_cleanup_begin() sets FULLSTOP_RMMOD, but each, once out of
its loop, waits in torture_kthread_stopping() until
hazptr_torture_cleanup() calls kthread_stop() on it, in the order above.

[...]

> I instead dropped the torture_stop_kthread() reordering from the most
> recent version of this patch shown below.  (Which still contains the
> above typos, but could you please check it otherwise?)

With the pass after torture_kthread_stopping(), each reader reaches that
pass only after kthread_stop() is called on it.  Cleanup now waits for
the writer before making those calls:

	/* hazptr_torture_cleanup(): */
	torture_stop_kthread(hazptr_torture_writer, ...)  /* waits */
	torture_stop_kthread(hazptr_torture_reader, ...)  /* releases */

So a writer waiting in ->sync() on a deferred hazard pointer left after
do_pending's last pass keeps kthread_stop() on it from returning, as in
the hang this patch fixes, and the readers are never stopped.

With ba9a3e4d3b237 and patches 2-4 on top (d0a4ec9443ee), both
3-minute PREEMPT runs with kthread_do_pending_ms=10000 hang this way:
after "Stopping hazptr_torture_writer task", the writer stays in
->sync(), no reader is stopped, and 3823 and 4072 deferred hazard
pointers are never released (reldefer - relundefer).

Keeping the reordering, or doing the pass right after the reader's
loop, before torture_kthread_stopping(), avoids this.  Your previous
version, which keeps the reordering, passed those runs, as did the
variant from my earlier reply, which does both.

> > Also, "hazptrtorture: Nest a second hazard pointer in readers" conflicts
> > with moving hazptr_torture_do_one_pending() up, as both add a function
> > after hazptr_torture_defer(); keeping both resolves it.
>
> I believe that I have resolved that correctly, but could you please
> check v7.4-rc1..d0a4ec9443ee in my -rcu tree?

The resolution looks right to me: it keeps both functions, and the
patch adds and removes the same lines as in v1.

Thanks,
  Andrea
