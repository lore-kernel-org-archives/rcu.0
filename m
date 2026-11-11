Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426632;
	b=39z0Eye2U5MsspP6g0/Eq3iA2HZq2N44uRxL4BearjfKZLDGh4z+aBym9LZu1vegk0LJ
	 YpgAGYLuagBrPIVY0h3HReCdMx5z78CmdUfoKjqJR3Vus9NGJoD9JG8uastNvPEwmeUuI
	 DtJXx8LSJaaZAbO7CFMCyuifuCh3eRNG2E9OTNn/oCsEkjP25i2PNxLd6TmVOtGF/zuQR
	 HT8uB/aI68SsRmtTGuYza6Ra9/VqD1NS+2YEzxMDzW6w0aezVyYl9g6KnLsRC+Rl7P4SV
	 uoumVWOLydYFD3rfA28oA8DH4LoA8hfnNhkAEvTJ+fD7HMOvYX+iSBkjLX+/KZaV5Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426632;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=L3UVurAsGYKzoZpueYiC1v8hle2LfnSk0xkR20EDL5c=;
	b=gussfwtfxD5QL7TcaTmx+/2eYy3rxvF+8WpsFVG0vDAaBabpAsM3oOypSDTi6vKKxtCh
	 yJhROMTWDwj3RJPFX9emnfJjpG4aGrIOGIBTCDq0OklN8u6XJwoISH7UnOlKNBAXfHyzP
	 uF9JVEpqqNdC0KZ/amg5Zsa/Zh+Z7K6ougOhcpZj34h5p7fmV2sFBJvFKPcjr+48BvaB5
	 0YzRk4hSJnpQ03QwlD6qunI/NB7TrkSkUicwo8De0ZSdv0ZNIF8mhgo4FZtjOVdhT3mNe
	 9nXYbnw5Iy4AdjTU9JUH28gqXXFFbUIE3au5SH/VPss9hFJF9o1PQs+9n6hx7v7QyGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDEUXvhu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A22606A31C;
	Wed, 11 Nov 2026 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDEUXvhu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F37E1F00A05;
	Wed, 11 Nov 2026 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426632;
	bh=L3UVurAsGYKzoZpueYiC1v8hle2LfnSk0xkR20EDL5c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=hDEUXvhu4EiG9gHrrFHayF1Rf8sUJ3aTyrhxV1YGCVhClwaBkLX3KjjfjLhN7aTTW
	 XaMRzi8Z4fubV+oFAeJKsECDQA9qFPhXU54X2wVN+p/nxkQopUcTqBBKh8veBuXT8q
	 5z4Kp3Ed1HVpYl8N8q2IT0dtGQHFrxZHcCpbFoMuA5d6ZbT7w/6UPuq3U5V0ysvJ3d
	 5BdKxKmo2kERri2onCxpGpZJxI75maEOPDwPKHMuCRIHIQ7GLLuq8O9bS7iTWk9l62
	 SMQ3Lvdaxj0J0aee7cgADUtHC+xFrqRAMCXG9HDfQNypbdFEFUadQLk13dPk9N2oAN
	 STsJsfIQUxUZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38E82CE08D1; Wed, 11 Nov 2026 11:50:32 -0800 (PST)
Date: Wed, 11 Nov 2026 11:50:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v2 0/7] srcu: NMI-safe atomic SRCU readers, and their
 irqsave forms
Message-ID: <5f4c0d2c-5abb-4aa5-9332-dc3da315cc76@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <50d177ddb1de4b84e9fd2cbd2ec5bdb7e32845d4.camel@infradead.org>
 <0782c3e7-9766-440c-b21e-e89b822927ee@efficios.com>
 <a8b4f18d81397124690a567b6a42da83ef2bc757.camel@infradead.org>
 <5edbc292-0004-43b7-9371-c3695afd9128@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5edbc292-0004-43b7-9371-c3695afd9128@efficios.com>

On Wed, Nov 11, 2026 at 02:40:36PM -0500, Mathieu Desnoyers wrote:
> On 2026-11-11 14:37, David Woodhouse wrote:
> > On Wed, 2026-11-11 at 14:33 -0500, Mathieu Desnoyers wrote:
> > > On 2026-11-11 14:02, David Woodhouse wrote:
> > > > The latter claim is only true in __srcu_read_lock_fast()/_fast_updown()
> > > > isn't it? Not in the atomic-SRCU. Unless we do something like this on
> > > > top?
> > > 
> > > It is true for the atomic readers as well.  Without
> > > CONFIG_NEED_SRCU_NMI_SAFE, include/linux/srcu.h defines
> > > __srcu_read_lock_nmisafe() as an inline that calls __srcu_read_lock(),
> > > and the same for unlock.  So x86 keeps this_cpu_inc() and smp_mb().
> > > Your diff selects the same functions by hand.
> > > 
> > > Only the architectures that select NEED_SRCU_NMI_SAFE get the atomic
> > > increments.
> > 
> > You are lost in a twisty maze of helper functions, all alike...
> 
> I guess I had the best mentor in that regard! ;-)

I resemble that remark!  ;-)

							Thanx, Paul
