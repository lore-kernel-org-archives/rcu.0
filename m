Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449593;
	b=z3buzstTKZG2ZGi6wBBAC+yOGt/aNfriDZ1AlwykVAcpV+I9ErbdLCummbL61xu3zp2S
	 pU2AVAJXXLb9jBIn1W5QSEsLsyOvBJud+TigCm7VrKlAr4L4XHky5VLLQhkxlqrqe/Ef8
	 QGKFSOAlXc7hJQxKWKUWfGXwbm+jvD7sBxJk3JW+Ko0UzjAVL5+TyIJ83106UG/KDuTWN
	 k9yhk6/J7vHFwJftw9w7nq6smbrxctE7DOl/hEFarfpaTqUMlNHxJAWZse58YLMh4ZGuj
	 r563ijTWvyAZj3SaVFRvH6VyojNr/8k2dOkdi7W4zCnGbN2tndDR6gFeoIp/XiNZbUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449593;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=BNMUN8XW2s5U2nU6fMxqRqWZ4506HV9JVZYwF8dHGm8=;
	b=HdeH0pkKVKJv3X9wd2LwCTLI8wm8NcSgIa2uLDq6WBE0TTBHbYf0MJe//d3lzcRJUUi5
	 NveDY72VOaHw00VYRgM8JCg3jncskxKeoMtiqZtavDNSpv1rJGd+jZ1FFvuLBL2tnqbmn
	 LiZmzivK0wqqd9jEbzOcqkyXbt+y6NA67DMznWsfXiUkTqbHU5MXnQgihXttaSAOUWQtL
	 YPzqx0FZRuuAdbI49SpyMQMNoB7v1QQcLNbQSsRgIgNrCxECVxJ6otAi8tNhVPmxVZDVI
	 CEpI7Woi2YN4BLt/UZiZdg7f08LQoaxp3liq15MDK3pstM8u+Qy/KkfSYu7j3YBgkWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apBkk58g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8D606A321;
	Thu, 12 Nov 2026 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apBkk58g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0A71F00A05;
	Thu, 12 Nov 2026 02:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449593;
	bh=BNMUN8XW2s5U2nU6fMxqRqWZ4506HV9JVZYwF8dHGm8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=apBkk58gGm+l3bVsXFD+jDtxD5GvI+hoyXEVxrc7SjWpk+0wKIvsMOliPFPQS0gtK
	 L1XBGmd84j0maUWk365VQeP1d51dIvHDGaUuCDvtgo4pXdfkf9KC6OO0ZoM5N4csOo
	 chv5PC/A8I75gJrOwlXE2FBQT81v/n3YcRO71+uOopk2nPv5WXiy2IKsK+2O75IERq
	 iKtywJa+ao24TR4LozvRJzvAjiH+XKfgfedAczQChVDQfDQCLT1MCXiCf1nupsFXWx
	 6yt0zgcTRn40r7eEheR0G9PBOxbeQMUTTTlswt8nYsJ19NOtVGLXkABEUDPBCNbdfB
	 FlrpTmSfjXQ6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 54F4FCE24AA; Wed, 11 Nov 2026 18:13:13 -0800 (PST)
Date: Wed, 11 Nov 2026 18:13:13 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 4/7] srcu: Add irqsave variants of the atomic SRCU
 readers
Message-ID: <78c1a437-ee80-4e83-8806-a7f7113a4b63@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-5-mathieu.desnoyers@efficios.com>
 <0f5b9d22-353a-4e30-91e1-aeea47461583@paulmck-laptop>
 <31ba97d2-f02e-4c43-a9a6-5ed49263c511@paulmck-laptop>
 <9207ad1c-fe1c-4041-80c2-52723bc58486@efficios.com>
 <9fc742ab-457c-41e2-ba05-0ef0bb15d00b@paulmck-laptop>
 <fc1bbc25-a410-42bd-b5b9-d734d2444b70@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1bbc25-a410-42bd-b5b9-d734d2444b70@efficios.com>

On Wed, Nov 11, 2026 at 08:32:48PM -0500, Mathieu Desnoyers wrote:
> On 2026-11-11 19:07, Paul E. McKenney wrote:
> [...]
> > Although that doesn't help on my laptop, it does work on my x86 test
> > system.
> 
> Is the laptop a hybrid CPU, with P-cores and E-cores?  KVM gives its
> guests no PMU on those.  kvm_init_pmu_capability() in arch/x86/kvm/pmu.c
> clears enable_pmu under X86_FEATURE_HYBRID_CPU.
> 
> > Perhaps something like the following would be helpful in keeping this
> > well-tested?
> 
> Yes, that would help.  Three comments on the patch:

Thank you for the review and comments!

> [...]
> > +             qemu_args='--qemu-args "-cpu host,pmu=on"'
> [...]
> > +             --configs "SRCU-P" ${qemu_args} --trust-make
> 
> 1) The quotes inside the variable stay literal.  The expansion is split
>    on spaces, so kvm.sh gets three words:
> 
>        --qemu-args
>        "-cpu
>        host,pmu=on"
> 
>    A kvm.sh --dryrun with these arguments stops with:
> 
>        --qemu-args (qemu arguments) ""-cpu" must match "^-"
> 
>    Keeping only the value in the variable works:
> 
>        qemu_arg="-cpu host,pmu=on"
>        [...]
>        --configs "SRCU-P" ${qemu_arg:+--qemu-args "$qemu_arg"} --trust-make
> 
>    It expands to two words when set, and to nothing when empty.  I
>    checked it with kvm.sh --dryrun only.

I used the same trick that I have used elsewhere, keeping a separate
variable for the tag ("--qemu-args") and the argument itself, as shown
in the diff below on top of my earlier patch.

Maybe I should use your more impressive display of bash substitution.  ;-)

> 2) nmi_readers and nmi_calls both default to true.  So the two boot
>    arguments change nothing.  They are fine if you want them explicit.

I should probably drop them?  I will figure it out.

> 3) The "atomic-srcu" run just above also runs readers in NMI, by
>    default.  It still starts without a PMU, so it keeps printing the
>    "went untested" lines.  It could take the same qemu argument.

I will add it there, also.

And to the --do-rcutorture stuff as well.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index b411a7b33abee..26901c376d3e5 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -528,8 +528,10 @@ then
 	if test "$ifnotaarch64" = yes
 	then
 		configs_atomic_srcu="$configs_atomic_srcu SRCU-T"
-		qemu_args='--qemu-args "-cpu host,pmu=on"'
+		qemu_tag='--qemu-args'
+		qemu_args="-cpu host,pmu=on"
 	else
+		qemu_tag=
 		qemu_args=
 	fi
 	torture_set "atomic-srcu" tools/testing/selftests/rcutorture/bin/kvm.sh \
@@ -537,10 +539,10 @@ then
 		--configs "$configs_atomic_srcu" --trust-make
 
 	# Half the readers then use srcu_read_lock_atomic_irqsave().
-	torture_bootargs="rcutorture.reader_flavor=0x10 rcutorture.atomic_irqsave=1 rcutorture.nmi_readers=1 rcutorture.nmi_calls=1"
+	torture_bootargs="rcutorture.reader_flavor=0x10 rcutorture.atomic_irqsave=1 rcutorture.nmi_readers=1"
 	torture_set "atomic-srcu-irqsave" tools/testing/selftests/rcutorture/bin/kvm.sh \
 		--allcpus --duration "$duration_rcutorture" \
-		--configs "SRCU-P" ${qemu_args} --trust-make
+		--configs "SRCU-P" "${qemu_tag}" "${qemu_args}" --trust-make
 fi
 
 if test "$do_locktorture" = "yes"
