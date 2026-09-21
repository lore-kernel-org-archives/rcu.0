Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979A3EEAE7
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022454; cv=none; b=Ne6bmA1scwGKLwsAtlAGc7D481IRB+wJIw5Hld+XhW3wO4o36+VdCUA1+uI39KfETaba0txbyttyiz7ho0UW++UrkrOktIbPYC6+r8lrlen6A549n3IScBed6kcQI3xNZFCqMzA94BP/5Al8vY3i+sUBnhjG3p0MAI08FDrRpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022454; c=relaxed/simple;
	bh=lVMLTEzECyAPw2fdvqa22EmMfdMZE0q0QYzqRNSogsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyhqBvLLOZO2Oy/7U+O8tAJaTanK7VH7kc/kCP/MF8vWcyiGNU9ABembkBJ4MeqUhz3QwHawrgD4MziWvZ8S6tJr6C29xAZXhXiOYsViu2998VF31hlTVuDSxrsBXmbQrwadR708U1fwpWdn1qpoVs7p64UxSqE3CwsOttO4NVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJNWeBg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJNWeBg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C1A1F000FF;
	Mon, 21 Sep 2026 20:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790022452;
	bh=6fypJfejMBtyOArPmo/Mio9hy4mmRnjDwcPnlc07K/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DJNWeBg0pDsbLKpCZyADmShb8Yvdm5Q4S+qOAb4aO5hoFqOU1jKJJoqilDSsko6fU
	 8vE8yGLP+Teu8/qXF7xp0OT+TwXIA82QIiSyDqQ21Io2uiq3+kVEMCz3+Py32lyQ53
	 viGgmnBILiggy5XL2J3NpGb/EqgptcKjhEjx5rEW4qjkUJ72G91OGQ4o0SHIpkwDQ0
	 CJMvagUewscsG2nDS2A6n19d+hTwdt4IRBCSPqtUwODJZyXpLxKrzmd8MWCJz+Wd/U
	 /KOT6hSBvqNQnQG3Yq0QFXcqOLUrR3BiwHamm6MtN8fwJ60Xcf4FyVVDYs7czvbeXB
	 DcEYSSsV4scTA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7A87EF4006A;
	Mon, 21 Sep 2026 16:27:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 21 Sep 2026 16:27:31 -0400
X-ME-Sender: <xms:M5Oxaucw4yd8ZDb0PTxouxQOOyhvw8bB644sgY088Foeg6azNnSYRQ>
    <xme:M5OxatIRLI6muTMUuoGvhFDnGuO6r8pZVO7QbQEP5EcbFuST81OeEGOtm-wyorI5f
    Rju_QazScxE-e17JMT558MKmkW1a3RxJVqnnMNQYoDhj9f2bggRaLg>
X-ME-Received: <xmr:M5Oxajxy3isfhBoNiKa-67MlDK3bLXDYIVINEbRp1LchXBM_la4UkaeNGroAhUYJiKJr8RYB7cU4YdWF9PZNmv3lJZz7jk61Fg6ov4Jx08lyfcYjHwCF6Zgo>
X-ME-Proxy-Cause: dmFkZTGJAjzjXr64oM6M6P1fVzuCB86SV7tatmH4h7suiBpHoD8t9OHKbPqxsPHbw1nmDm
    1JuqZqPYqtjR7DLOgZqgipipaP3CERsEtABzoJHu9CHFK5WqJPiVKxyZ+QXJGasbszXRsX
    95I8tyDlJvfTGPXxqaX7SgWGq4PiV9o4Ohzke5+gOU8w850ZIblm8lUX+MBzRo8lSlDASw
    +38/ByqXs1qhovCTo4nCGnLaYWwXy4fZkqQphmn4YzNPRdjK6J5mZnmbNL+1TnCs1VOQtJ
    D3IwRNcAb0cNYIUm57rxn/wapJtblwtAQep+wKnbzDR8vPD1eLh+TuKPo6/6Gq4oKMffmJ
    ry0Pt/xekgxZGDox6tb47OIyvFnx+v5fvXtC/IPpdsod0Ij8x/X2PP27zXz3/c5ZXChIlp
    SurCSQhcgXXjkENh7FOMU/tvEVi7i6XHBQr0qgvolUJ4/9Ymq83b8fjjvtmFV5TXB8L/lJ
    UEC1OUPLJAxoT2H/3PVThWKvTgn2UiV970Q9IGC8p3qZ4V+aRtJa4HH+1KaGNHvuG28hhr
    xJ+GMFem2jLXb94rgZvYJIrHsxaKhf8//IljtS+dAzn6Wo0UlkprOLsazeMSiORbdXrCwz
    1Y/Ykca3jDe+oFJRWMlDjYYyQW6bEPUhk9NLCiYQ3BMgxVt91zFflC4ldcbw
X-ME-Proxy: <xmx:M5OxartBSvGqzM3B9HqwjW87GzG0enNGhm4FPZUXi9nYaYTpRqVZZQ>
    <xmx:M5OxauD6Fv-IRwZVUdMg9Dv4WF0UhIttCXKzuSg0gHzO_U_-h_d1Lg>
    <xmx:M5OxalH4eUDos5nodRj7n8xOZrI_WrljBSUcuhJgNWd2GokfkqCKPg>
    <xmx:M5OxamC5WaXXoruMzxGR4RaK4OdwI-y5XjSIl8Y8RvYqJ8PnnSjGug>
    <xmx:M5OxajkvtViFwhcXBBrBv52cjRGFKpabkJ65z_vecyOVsYURvbAw6o_W>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 16:27:30 -0400 (EDT)
Date: Mon, 21 Sep 2026 22:27:29 +0200
From: Boqun Feng <boqun@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] srcu: Add lockdep coverage for atomic SRCU and fix
 IRQ-state bug
Message-ID: <arGTMdkrE3oMcBq3@MacBook-0RXW5>
References: <20260914093419.1474829-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260914093419.1474829-1-kunwu.chan@gmail.com>

On Mon, Sep 14, 2026 at 05:34:14PM +0800, Kunwu Chan wrote:
> The atomic SRCU fastpath enables synchronize_srcu_atomic() to be called                                   
> from contexts with interrupts disabled. This series extends the                                          
> rcutorture lockdep tests to cover the atomic SRCU path and fixes an                                       
> IRQ-state preservation bug discovered along the way.                                                      
>                                                                                                        
> Patch 1-2 add lockdep test coverage for atomic SRCU:                                                      
> - testtype 4: same-type atomic SRCU deadlock                                                            
> - testtype 5: atomic SRCU + raw spinlock dependency cycle                                               
> - testtype 6: rcu_read_lock() -> synchronize_srcu_atomic()                                               
>   legitimate nesting, must not trigger lockdep warning                                                  
>                                                                                                        
> Patch 3 fixes a bug where the synchronize_srcu_atomic() call chain                                        
> unconditionally re-enables interrupts on unlock, by switching to the                                      
> irqsave/irqrestore variants throughout the call chain.                                                    
>                                                                                                        
> Patch 4 fixes a pre-existing double nerrs count in the script.                                            
>                                                                                                        
> Patch 5 adds testtype 7: cross-CPU IRQ context mismatch detection,                                        
> where an atomic SRCU reader held with IRQs enabled on one CPU is                                          
> paired with synchronize_srcu_atomic() via IPI on another CPU.
>  

Acked-by: Boqun Feng <boqun@kernel.org>

Regards,
Boqun

> Kunwu Chan (5):
>   rcutorture: Add atomic SRCU lockdep support
>   selftests/rcutorture: Wire atomic SRCU into srcu_lockdep.sh
>   srcutree: Preserve IRQ state in synchronize_srcu_atomic() callchain
>   selftests/rcutorture: Fix double nerrs count in srcu_lockdep.sh
>   rcutorture: Add atomic SRCU cross-CPU IRQ context mismatch test
> 
>  kernel/rcu/rcutorture.c                       | 109 +++++++++++++++++-
>  kernel/rcu/srcutree.c                         |  42 ++++---
>  .../selftests/rcutorture/bin/srcu_lockdep.sh  |  77 ++++++++++++-
>  3 files changed, 205 insertions(+), 23 deletions(-)
> 
> -- 
> 2.43.0
> 
> 
