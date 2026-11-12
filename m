Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442050;
	b=ney9L/568pdulelCMSq8LOtNd8nBVRZzUhOuZ49apQU+SYOWINWkpZTW94s7RgzVN7oe
	 7d1JeZQjXWMU4xFuWEm0lXcmS0IL088ibZcGDq007zlsV818F5cDWdN06h5WRlRlW8fJX
	 0P9IJKKlpLU1CyLYRh18343NKxWN7z1FFq2FTUYIuWLLmDzEChip8IlS8Q9hVcti1IrrI
	 ulfyNXzHC6MToL05qfbdh1liLXx9+pPlwAS124QykvTort4krGPDJe7Br010sEwy3m03f
	 V1GCFHPOUgf27Ku4oDsvV9n2kd5FFlFZ18MosHZ/MKTEsPeTf1tN3wbPggwJeFnPs3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442050;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=YMGIWRpfe2cl15HYdWUEoJP/r8nb1DxI/GQ95oPCJ3o=;
	b=Az1v9HoVWT8FLLMMweCL3i8ssvrgx8IPNm3p4p3ho6TxnSFb0zjqMWQH4u6JAz6IbKXR
	 tFMQ7K9bN22HIWtliEpM0n+HKWlzK0+uukbfDB6KVkuEW6TFIvfx5lSq4IAKXYJUpjPjL
	 GfmoOOyQ3vWr6CgmDOvhHVGjTgoLWwhp+aEx4fzOeOndH0UDjMycGGAy6T0t0bTwGgYwS
	 fxmAMXQC8uF1CmqJ58LqQXxbAcqBdfAmG7SuAzgYn+Q6mLbgWd/vWB/E8hzChK+EnHLOK
	 U5+OPNSp97Mq/HvBHCckR6BTggSXDP8rqkP2GboBBxSmCEwv4v9y/H38OD2Eyoe9ZmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtSivTCZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED74606A31C;
	Thu, 12 Nov 2026 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtSivTCZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAA71F00A05;
	Thu, 12 Nov 2026 00:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442050;
	bh=YMGIWRpfe2cl15HYdWUEoJP/r8nb1DxI/GQ95oPCJ3o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=DtSivTCZm+HtCXRAFdaK67400mK2lXg0/1ZXc+S4JqOslCH+Wn/bHbDPt9PB135YY
	 H7PVXtQbD4B7F0g9B4dg2tHcCUPw4Ij9mc7N46gWsD/5WTw3UI23+BIiQ0eTcb93By
	 vK44crA0ubWVygUwAgMmEe7KtfXysladvr0owY95k/6iy3Qxz4OlFrvunPiAsxrujl
	 Pf8XOd03oNDAU0iDsVbxQ+Uggu5Diu9AnZIyIxoTlmJJH7Ld9hmXKrFPZlsPIAFqmA
	 BlLKav2SbK16bHqm8xXfRHi3+0C6Ce1gljRlVS5KBUA/zvLzbzRK7TuJg6YOIOvLvR
	 OYumarfjwojag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DC02ECE08D0; Wed, 11 Nov 2026 16:07:29 -0800 (PST)
Date: Wed, 11 Nov 2026 16:07:29 -0800
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
Message-ID: <9fc742ab-457c-41e2-ba05-0ef0bb15d00b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-5-mathieu.desnoyers@efficios.com>
 <0f5b9d22-353a-4e30-91e1-aeea47461583@paulmck-laptop>
 <31ba97d2-f02e-4c43-a9a6-5ed49263c511@paulmck-laptop>
 <9207ad1c-fe1c-4041-80c2-52723bc58486@efficios.com>
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
In-Reply-To: <9207ad1c-fe1c-4041-80c2-52723bc58486@efficios.com>

On Wed, Nov 11, 2026 at 03:13:34PM -0500, Mathieu Desnoyers wrote:
> On 2026-11-11 15:04, Paul E. McKenney wrote:
> > Aside from this in the console output:
> > rcu_torture_nmi_cleanup: nmi_readers set but no reader ever ran in NMI,
> > so NMI readers went untested (no PMU, or NMIs unavailable here).
> > Looking into it.
> I expect this is a guest without a PMU.  The NMI source is a perf
> counter, and kvm.sh starts x86 guests without one.  The readers in NMI
> are then skipped, and this line says so.  The nmi_calls test prints the
> same kind of line.
> I ran with:
>     --qemu-args "-cpu host,pmu=on"
> With that, "NMI Reader Pipe:" and "NMI Reader Batch:" show up in the
> statistics.  The cover letter mentions it, but the changelog of patch 5
> does not.  I can add it there.
> Thanks,
> Mathieu

Although that doesn't help on my laptop, it does work on my x86 test
system.  Hmmm...  Trying an ARM64 system, which unsurprisingly fails,
presumably due to a complete lack of NMI support.

Perhaps something like the following would be helpful in keeping this
well-tested?

							Thanx, Paul

------------------------------------------------------------------------

commit 7b946ec45af11815e2341d91ca0e9ac7c2372481
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Nov 11 16:03:48 2026 -0800

    rcutorture: Make torture.sh test NMIs for atomic SRCU on x86
    
    This commit adds '--qemu-args "-cpu host,pmu=on"' and kernel boot
    arguments "rcutorture.nmi_readers=1 rcutorture.nmi_calls=1" for
    --do-atomic-srcu runs of torture.sh.  This ensures regular testing of
    atomic SRCU readers from NMI handlers, at least when running on x86
    systems providing PMU support.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 804faa456d386..898e602a00f46 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -528,16 +528,19 @@ then
 	if test "$ifnotaarch64" = yes
 	then
 		configs_atomic_srcu="$configs_atomic_srcu SRCU-T"
+		qemu_args='--qemu-args "-cpu host,pmu=on"'
+	else
+		qemu_args=
 	fi
 	torture_set "atomic-srcu" tools/testing/selftests/rcutorture/bin/kvm.sh \
 		--allcpus --duration "$duration_rcutorture" \
 		--configs "$configs_atomic_srcu" --trust-make
 
 	# Half the readers then use srcu_read_lock_atomic_irqsave().
-	torture_bootargs="rcutorture.reader_flavor=0x10 rcutorture.atomic_irqsave=1"
+	torture_bootargs="rcutorture.reader_flavor=0x10 rcutorture.atomic_irqsave=1 rcutorture.nmi_readers=1 rcutorture.nmi_calls=1"
 	torture_set "atomic-srcu-irqsave" tools/testing/selftests/rcutorture/bin/kvm.sh \
 		--allcpus --duration "$duration_rcutorture" \
-		--configs "SRCU-P" --trust-make
+		--configs "SRCU-P" ${qemu_args} --trust-make
 fi
 
 if test "$do_locktorture" = "yes"
