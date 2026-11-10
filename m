Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269544;
	b=mXHocm16ItZfqkakgAOcRszMIkaBhhBD/gkqOBn5Z0Dr4BsgWDbVmDOPvs2GBTjOeViw
	 9Jg/fmKzZ88Czql5QBM0GpQmCLMZ89cTrDeHLBWc1K/Evb+gmuwIvA1FoLBaqfbjrbOMY
	 63VqZHsAXnZv/sUOCwCjLZrh9Nalq+ZsiHSR6FBVAIES/m4Y27lamDufdvf8qtFZL3eZl
	 aIJbWUqKguduwgN+YM0Hl41pH5opaTMnTj5/dEMucSqdWHZgxc6nUNtQsO25weEmV5pyW
	 U/V2hKN/xAz03OTrhZdu9u3nQZxgXJooD7G8yqtgm0GUdAH3r/msHsNIbjxm32dgfBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269544;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=IcvF0Y2+Ue8K/A4VcRAwUtlLAARKuCPNclQYGp+xjhw=;
	b=pONIBdtsEIuwgjW95OjZ1x0L2noJ25hrN4tA/s1z3n8A4juHdKzYXB7CMyKUehNdlJA8
	 RDkrXYEr2Pyrm37PZM66I/Zq+9kdKrOUjlSa53z4xJdWHKQw5+trDSTn5WYgbWkLMZOMu
	 2RxSCDhB9i5JDaRfxoRdxCMdAeS11cStLKgRU7a7RVhJkQrqK8YcVbk5ykno5MYFOvWji
	 ohouVeZ1KsqJeIrEcoSEwwZKMk2u1L2LgEEmVBUlnVa2yk0gPhPzx/X6yFuwUQliI85v8
	 B0xav1UYWn55X0TnLC9DHOc6ufgzpdS7i3rueNdYLNlVYbsXzhJxccF4FiTfOHiEZzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KB2ZRlhR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9E606A321;
	Tue, 10 Nov 2026 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KB2ZRlhR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7651F008A1;
	Tue, 10 Nov 2026 00:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269543;
	bh=IcvF0Y2+Ue8K/A4VcRAwUtlLAARKuCPNclQYGp+xjhw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KB2ZRlhRUGV/qguOKLpGMCqnKUz0WRWQ5tiWXXT4tDz5ItWZ+86EKOnomMsWF//ef
	 xvA3TkoJ54YySjY6T0phu1PnO7u7tSPjVfu0qyqLSamqFgwFtAezkwytlAk3IBc52y
	 hTYo+ObXvc1LOPfV/H7/TQ/4SNNJ+jXDUd6AU+vt4dxufzuM7Noc4GX2dKwjjmoDBC
	 BCwdEb9kCVV7KPUjKw8pEbaOm/6YBuXwfOSSd2ESaKQ9nD31B3ZfvoDE1V8qG8yzE/
	 CnFrdVrqvr+m85uma9U8vsJZhw7Gyq+sDAfh54MzdKt8dhdxvXjndGS0NVQxL2bVGv
	 NbeM77QAyftTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63BCECE0C97; Mon,  9 Nov 2026 16:12:23 -0800 (PST)
Date: Mon, 9 Nov 2026 16:12:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add scftorture to TORTURE-TEST
 MODULES
Message-ID: <69f1c0b3-a314-4743-9fce-1d9d726f071c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
 <20261109000243.3936824-6-joelagnelf@nvidia.com>
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
In-Reply-To: <20261109000243.3936824-6-joelagnelf@nvidia.com>

On Sun, Nov 08, 2026 at 07:02:41PM -0500, Joel Fernandes wrote:
> kernel/scftorture.c has no MAINTAINERS entry, so get_maintainer.pl
> reports only the linux-kernel list for it. It is one of the torture-test
> modules alongside rcutorture, locktorture and refscale, so list it in
> the TORTURE-TEST MODULES entry.
> 
> While add it, add me as M: to torture modules as well as I have
> contributed patches/fixes to it over the years and use it for RCU.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Welcome aboard!  As usual, congratulations and condolences!  ;-)

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065..5c068224048a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28282,6 +28282,7 @@ TORTURE-TEST MODULES
>  M:	Davidlohr Bueso <dave@stgolabs.net>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  M:	Josh Triplett <josh@joshtriplett.org>
> +M:	Joel Fernandes <joelagnelf@nvidia.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
> @@ -28290,6 +28291,7 @@ F:	kernel/locking/locktorture.c
>  F:	kernel/rcu/rcuscale.c
>  F:	kernel/rcu/rcutorture.c
>  F:	kernel/rcu/refscale.c
> +F:	kernel/scftorture.c
>  F:	kernel/torture.c
>  
>  TOSHIBA ACPI EXTRAS DRIVER
> -- 
> 2.54.0
> 
