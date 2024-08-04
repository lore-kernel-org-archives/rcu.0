Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546D1DFE8
	for <rcu@vger.kernel.org>; Sun,  4 Aug 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787465; cv=none; b=EAbNUmI5BzZ1Rw2+1zNWLzQc/gERrolzumXHKrjq3i5rA753XMQIF9Jn+bOWMmZlfGn2Zzc3IIjiu5s5T1HAhREx6CdB2qeiV3+KxKptKEv0nBdbhJehgK8QttJV209wolxHiHbzu95QnTNNlsarEudY6j1ZEwS9sUjywFtSKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787465; c=relaxed/simple;
	bh=1P54t43gCBFv7rtbpgzYgnTUjy+auEtDMggD5kQgVtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPdAXObBCH56Y47MFrloiTs5MMDoppK6+awQ4b/F2P4SOsyjnXZoSyB30GgO/nu04AKsIRGkZ9VNPOaIcUE5jBv9GFqU1mEdDptphrEP4241vNZwKr8cHx0LC8qpn7jM8pKsNa8b5+mCoY54Fo+LNVI76r0LhluShFv5VCKAMuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw+4fJ1R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw+4fJ1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9AFC32786;
	Sun,  4 Aug 2024 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722787464;
	bh=1P54t43gCBFv7rtbpgzYgnTUjy+auEtDMggD5kQgVtE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lw+4fJ1Rm372KwcO8FrMrxgIEQCo0FFXQUncKavGRL5urluFaQH3CFonMEyx5xsqq
	 OpELCQA/Oywl6h6jjHbIIkK9iGiMzFCg5PFMViFsbs39Of9gsFBFr8wSUapzo354pZ
	 Nv+OOBNlBMI6TinvumZhGvaBl6SnwvZQLyoF4UBzzlpNS3WQ3QN/FsTBEE811kHVVT
	 ESWkZ7ATTxcr3zeX4FOoE/i3rQ0Upb1r9FQYtEt8MJrhCgTlp8grRH6KycXlH/cqc4
	 FjVLpKoaliX3HJJ8CfLlIU5/hHggH2AgdO0fLB66v4NIXB41ThA1Y41VHIddHgR3zb
	 hZ4tKB+3hXY0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AF344CE0BC5; Sun,  4 Aug 2024 09:04:23 -0700 (PDT)
Date: Sun, 4 Aug 2024 09:04:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Olivier Langlois <olivier@trillion01.com>
Cc: rcu@vger.kernel.org
Subject: Re: unexpected result with rcu_nocbs option
Message-ID: <8bf3fcb5-119f-40e5-8d75-558ee7c603df@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
 <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
 <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
 <f7b2ea1fd826c502963d574e4c229de4427440a7.camel@trillion01.com>
 <70ef45ee-2547-496a-aed3-27cec933c671@paulmck-laptop>
 <560ef22942010a3f0ea4ad43e0dea048fe967369.camel@trillion01.com>
 <383ce0ce-fe27-46a5-ac1e-2dd2ea2be4fe@paulmck-laptop>
 <a38775aa4f97b50844e482ab05a51b13a8f11aa5.camel@trillion01.com>
 <2b9f8637-2d91-4981-980f-87e4aeb4c1b2@paulmck-laptop>
 <0378062f00156325f18fa683f5504772c4b4956f.camel@trillion01.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0378062f00156325f18fa683f5504772c4b4956f.camel@trillion01.com>

On Sat, Aug 03, 2024 at 06:46:44PM -0400, Olivier Langlois wrote:
> On Fri, 2024-08-02 at 16:57 -0700, Paul E. McKenney wrote:

[ . . . ]

> > These things go on a syscall-by-syscall basis, and much depends on
> > your deadlines.  For example, if you had one-millisecond deadlines,
> > those 27-microsecond interrupts might not be a concern.  ;-)
> 
> this is for a small crypto arbitrage trading client project of mine,
> the trader that react the fastest wins... 27usec is a big deal. It is
> the difference between winning or losing a trade

Given arbitrarily short deadlines, you will need to be extremely careful
what system calls you use.

> https://x.com/lano1106/status/1771345949320737183

Huh.  I thought that high-frequency trading moved to special-purpose
hardware some years ago.  But maybe crypto arbitrage is not yet large
enough to justify a big up-front investment in special-purpose hardware?

							Thanx, Paul
