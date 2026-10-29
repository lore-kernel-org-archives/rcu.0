Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285270;
	b=PejXNl8tRerssCChmHKlhom3eXW1ceUCCvTNydkhDXwYudFRDCbyks9ZnbUGd3zGC+I+
	 yTmU1YX4j2DVe8eiVwE+JM+vdlLrjDLDioR91wiQYt8P7hA/PByKF62LMlOrysO10JTNg
	 RtVXSHaN8UWjZtEl1v7ZeCIGREXIeBbtHmqz+ntYiSN+dI5O0KKsZun4rryl9f75buiEp
	 Uv4iQKSCaASeWHfhlF6SgK2xajg4Rk4/oadkpkEbfgz1sCwiF3uvpCHASXqkl4buN/Bwb
	 E3M3sd79N/2lem+z52IHE5uoekCsyg8jm+AzZ/zGdFjMEYnGpxL4EzISlStlzOASCzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t2RLRcd4jJhvrI7zbg6jPMwuOd13g8I2G+u3G4j4wno=;
	b=PGWJXpIog015YYx36mCeWiuXqlgIKkYnoJWkWHZ5B1xy4gJi8ONI1RppL87Vv9kW5RDJ
	 BHvC6/vpzmr6sOOWIRJZftPnN31CJycJ0u3Ymp9KTvOohPys+jkHOu9ipCvI17BWYG+19
	 DuRRmojr2gh9EbwjuQpej1VAiu7bQIh6wkjg4taX+100X/FN8RO8qSSTgKj+q/1eios3U
	 wFYsb9tlqc6hSVzdaJFjAW8Ia+QihXAIqd9CDt/IaDRwFUi4rKvBOA3xOpuAW0tVEgboX
	 NT0I7nRQrCuRlvpSX+P54/KEmI0/SRStW0wWjkjQSLuXtf9TUxveyuB7Q71qx8+r5nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0OFZCmkh;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB65606A31C
	for <rcu@vger.kernel.org>; Thu, 29 Oct 2026 14:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB65606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0OFZCmkh
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so22400625e9.2
        for <rcu@vger.kernel.org>; Thu, 29 Oct 2026 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793285268; x=1793890068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2RLRcd4jJhvrI7zbg6jPMwuOd13g8I2G+u3G4j4wno=;
        b=0OFZCmkh0R6XFSiXCMCoda+dB88WuLiiF3wV1jsn18ajZN0M9RJ0ZI2l2IO+aIzMhG
         eQTGx179mr9H9jdNlKdIDxOFSs42hUh8K5groqTtnwF62GjL95WcBGTK/VHMkyy/gfoC
         9ifdc1hNjM60fF2UAJlKM707FLSopDFs/V46q1NksIMHcneVfVEPGiOOBw/JmLhD1uDo
         xN9Ox7kIneeh4EMCkYStn0bWs20nDpCq6CTc9ad+NiRd/OFZZfZ+T/sG9KAdk9OJqy5O
         TTIjLxWMWyyxopurFGbYiqeE++uqUr5yxHENWfPZzp/IT6216175cC4L0SaydMvv8ARP
         DD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285268; x=1793890068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t2RLRcd4jJhvrI7zbg6jPMwuOd13g8I2G+u3G4j4wno=;
        b=irCqsLawV8jgsP70K6UFveyLRTN2nZrKQAwrAfIA4ts/xhOg8ZFcVr17QiUiZ8grfJ
         wMgWseW9nGWiGPMghYOdPCqNGFZ6MlNR2xlJpWg02ZUcojSahRBUoSnHUWqZF1tnjd0C
         PqlxpAMH+/BHEjg9yB1pZ4F2xitcm+SbikynU7AGyMV1M0g15sQ6rIPbUSFCSG5BW0t/
         JIzn1IVlX9chTqH/tLwTj/BAzhwTZeJvCj3RVcNX5H7hYJ2wp7TRJNxO43uaILv1rcCv
         WBPzyL/pG/9u/h6OxBAcV1ghbYWb6vc1V8QW60Ac6QEIKKxKR/T8/DaFSUnZgtzhb4ZD
         mT1A==
X-Forwarded-Encrypted: i=1; AKwUvBxE3cokH1aVM+ZCVy2xAGjqFlgUBxnCpCwZ8qpnSMINYM87SbbWx71WoADZ3ezMKYOdPTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCpvk0bB7sKg8WzUICW5kEQqDbgurKa2TZcsJruw87Ci5lQ3au
	DbSlrcin5P6bQDMDUTwNN9fg9KHQYhNJ6uLUxMoNgeQOMK59dg9Mo/6n
X-Gm-Gg: AYBFou1sG393qBU73MHZJrPhkmmlYmJHmo59CWyZCh8w3Oycg40a0fkugjUJx1gxYCF
	OPP5XrN4cJTdR/rDt7kFXF+u1tFaa/dSErRYvsDo7/5OpwUznYErmxoeTxWfe7bR/Z/utMh1HtS
	eaqJjJ0GOY38pOjJXPL1XFnUWqMsngE0PYSqv8jph0EkHpemBzuRLxjK+s6WgZEctUBXyVntfQW
	7VwFngFDWdH3/8vv0HDHClCiy3rHl0JFHaBOWrUPDa6eAHMcXNP0s8ERR9y/ccXQo/hLdiSI0cg
	6P7hOdv6TtuM5VhWV/vNFtRihUrAPGChUnnwGttkdkwrDcY+YLg21UknKwYDeLgjnuwNBpPl4p/
	SZrR0+EhT5DbLcDYMJWL4/vgUWRbHRuT5ie1EmkMAfRXG04d6oPp50kNgXZ1Vdqd7tnTglbt6Ag
	aQnUykUPa54OwCMlHS/ky6ytKjZAX1m0RiHHXion70I+yV3ACrEDZRT1XvPQckvlbJBoDO+bzP3
	okaz1KmkS6IQXN3M9qTsoecM0vEEA/6D150bMgilTacZWIN12U5aHx3IVNQq6KlTz+GP1GD67kl
	x10I+ifYYYK1oKqJ9H9IdFCY4QQzvwfhzk77gdaoAMKbNps08EOGj4+oIqWb2JApXuQPpnWZkyp
	qyC+n
X-Received: by 2002:a05:600c:4e03:b0:4a7:7d22:c50c with SMTP id 5b1f17b1804b1-4a963ffcf87mr130861115e9.2.1793285268267;
        Thu, 29 Oct 2026 07:47:48 -0700 (PDT)
Received: from andreayoga.localdomain ([151.57.246.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7c5063e3sm71561005e9.0.2026.10.29.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:47:47 -0700 (PDT)
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
Date: Thu, 29 Oct 2026 15:47:28 +0100
Message-ID: <20261029144730.213196-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9da03ed6-fea2-44df-8aee-f7a61a1d35ce@paulmck-laptop>
References: <20261027163811.2470569-1-parri.andrea@gmail.com> <20261027163811.2470569-2-parri.andrea@gmail.com> <eb59edbb-c6e8-49c6-a426-c55cdb792853@paulmck-laptop> <9da03ed6-fea2-44df-8aee-f7a61a1d35ce@paulmck-laptop>
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

On Wed, Oct 28, 2026 at 04:51:12PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 28, 2026 at 10:26:18AM -0700, Paul E. McKenney wrote:

[...]

> > So doesn't the above torture_must_stop() instead need to be
> > kthread_should_stop()?
> >
> > As it is, hazptr_torture_do_pending() will still stop before the
> > hazptr_torture_reader() instances do, correct?

Its loop does exit first, but v1's for_each_possible_cpu() pass comes
after torture_kthread_stopping(), which returns only once
hazptr_torture_cleanup() stops do_pending, after the readers.

> Well, one thing that I am missing is that changing from
> torture_must_stop() to kthread_should_stop() might cause trouble
> if rcutorture execution is terminated by system shutdown.

Agreed: on a shutdown that hazptrtorture did not start itself, the
reboot notifier sets FULLSTOP_SHUTDOWN, and nothing calls
kthread_stop().

> So my next suggestion is that this be added just after
> hazptr_torture_reader() exits its do-while loop:
>
> 	for_each_possible_cpu(cpu)
> 		hazptr_torture_do_one_pending(cpu, &rand);
>
> Thoughts?

Works for me, thanks!  I have been testing it, instead of the
for_each_possible_cpu() pass that v1 adds after
torture_kthread_stopping(), and keeping the torture_must_stop() loop
condition.  I will send v2 with it if it holds up.

Thanks,
  Andrea
