Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457531;
	b=WYJ/nWwClDmCCWrG1UxnhrQNF4ptIKXoVPDM8yiTugEzRBUYoke7Bl+MXLS9XHbnC0qW
	 LO9wl9Hg1HutITSOVKWHFX3Zrp6WDBV6w/QMEipxYODkzYesBIx3sjzVamR1iCXfVlmxt
	 jBIlqxgsEDIA4SBhard8lZ9Mn+tD1A5bKVTnopvM5vx7JzI8Q9Q8rviecvJjdPfS/wvMq
	 FykikCIRfnTsgRMCYyPwjr5KkVPPJzfMSW8WSc1g8CnZltl6IMHlOlb/960xg5T9WxZcj
	 vLK71zolTZ4oGKifbZeC4zQ/b5E4Y67z4ovVSEqTnlOtnUeFgYpW+jAaGlZ0/LYtUAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457531;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=x2OyaPiM8VzNGwESrDCi29D4joiGpyq5DaOagbQ+zgY=;
	b=0gKqe2yBehOWYRX9mdcWjYcN3IygZtdkxFYICz8ujdMEMOHWHSU3LUNT4FlQgPIIXr0E
	 zVo2v32XvH92BEgvgc/5cfNycJ70w7pZKLnTLV3ZZMZl6yauIWKHIaGPOV/ENPkWyvOCp
	 tLbsz4teKCGU7hhD3bKwKEO3QRL1YCp3aBpn0Xee3fcXonU1VwZ9/X1/tqdh7ZrL9WUsX
	 9iNU/O1U5B2ONxH+pSTxPtTUFxkM0WRlvfrwxgyHjpQqD6T7M3xUbP3sqwV31i7l49DiB
	 b6vM3VcCLUyZ8tiJLbgpmx60FwEoR//e3vzCF+fggSrT99fDXEoHdDZ+7ZP/jav7lPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KS/SlFsa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899B606A321;
	Thu, 12 Nov 2026 04:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KS/SlFsa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4F81F00A05;
	Thu, 12 Nov 2026 04:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457530;
	bh=x2OyaPiM8VzNGwESrDCi29D4joiGpyq5DaOagbQ+zgY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KS/SlFsaO11cfINJh2wnQGU1PW/lBLhuEZSyxX1GOutuwsoFsc7yWfaiADTDaGziJ
	 WDGrrW7mWK3XnyqZmnxomH8XSsjOCCEm45GXVpeiuMnJlTh8eOXQH8+6Q1Jiv+mSkr
	 3W5Szl4ZmbtMOvP0r+5O6XnvBqX4EmQvlSad/C75NYI9l622MpqSkxKjpbox/+tkEs
	 tyD1ygzXAIlfwPqqmhheqcpp548rHrwmnX58RWfDYkel1GuTF8fCA7pxEu+9deAelg
	 7FdOCca8RWfTplFoLZU4J4feakYNFhj8yxWZCPBPhk3HPxle1mkQ+b+ZUkdKB7Qq4q
	 wXdkJ2PRE4r1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7F146CE28E6; Wed, 11 Nov 2026 20:25:30 -0800 (PST)
Date: Wed, 11 Nov 2026 20:25:30 -0800
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
Message-ID: <408366d0-3612-47a2-bfce-7ee52828f3ae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-5-mathieu.desnoyers@efficios.com>
 <0f5b9d22-353a-4e30-91e1-aeea47461583@paulmck-laptop>
 <31ba97d2-f02e-4c43-a9a6-5ed49263c511@paulmck-laptop>
 <9207ad1c-fe1c-4041-80c2-52723bc58486@efficios.com>
 <9fc742ab-457c-41e2-ba05-0ef0bb15d00b@paulmck-laptop>
 <fc1bbc25-a410-42bd-b5b9-d734d2444b70@efficios.com>
 <78c1a437-ee80-4e83-8806-a7f7113a4b63@paulmck-laptop>
 <b81abda5-e882-42e8-b780-6db34fdd0092@efficios.com>
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
In-Reply-To: <b81abda5-e882-42e8-b780-6db34fdd0092@efficios.com>

On Wed, Nov 11, 2026 at 09:50:26PM -0500, Mathieu Desnoyers wrote:
> On 2026-11-11 21:13, Paul E. McKenney wrote:
> [...]
> > I used the same trick that I have used elsewhere, keeping a separate
> > variable for the tag ("--qemu-args") and the argument itself, as shown
> > in the diff below on top of my earlier patch.
> [...]
> > +             --configs "SRCU-P" "${qemu_tag}" "${qemu_args}" --trust-make
> 
> This works on x86.  On arm64 both variables are empty, so kvm.sh gets
> two empty arguments.  A kvm.sh --dryrun with "" "" in that place stops
> with:
> 
>     Unknown argument
> 
> Dropping the quotes does not help: the value has a space in it.  So I
> think this one needs either the ${qemu_arg:+...} form, or a test around
> the torture_set call.

Ah, you need the kvm.sh hunk of this commit in my -rcu tree:

436f3c6b27de ("torture.sh: Add hazptr torturing")

Which I clearly need to extract from hazard pointers and get more widely
available.  Diff shown below.

> > I will add it there, also.
> > 
> > And to the --do-rcutorture stuff as well.
> 
> Sounds good.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 32c3199976388..86dd5c131d226 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -271,6 +271,9 @@ do
 	--trust-make)
 		TORTURE_TRUST_MAKE="y"
 		;;
+	"")
+		# torture.sh can pass empty arguments.  Ignore them.
+		;;
 	*)
 		echo Unknown argument $1
 		usage
