Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AB2ECD2B;
	Thu, 26 Jun 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948654; cv=none; b=Cb3oxA+VMMI6lFZw7rjOl7K0HnhauUt2w1zqKO1vyb09g4f3t7OW0JhfiQ79PXan/IKpFtdKSWKFBSki0m45D284cRI5Rz8VXYxcjcH4zBW3uoB8Dx7/9XVDP0jwJj+UR55T9TF+mSgfmzEFZuzEVOgYrPyUk/LMDCjCXdzI9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948654; c=relaxed/simple;
	bh=EW+h82wtp2A60orQKZ61oadjcgfTklo//2pBX/iOgMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ9jJvUptvleSYcguqfvHKg72t0crXw2Ugx275qqqv6CnWUYLO8jfx8GnmgbEumEcJTBNddlli9VmPi1uCQviGZY4IXNs5NX3DejEnSLMOT/5uRxbzqL+PPof8D4qgtFKsz039Ea3Pd5BXk0+bbRviiaaaIVq7CeolktmBbXEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFPUDpBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFPUDpBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC9EC4CEEB;
	Thu, 26 Jun 2025 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750948653;
	bh=EW+h82wtp2A60orQKZ61oadjcgfTklo//2pBX/iOgMc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hFPUDpBvkhmhDPlcwL7C0xD/FkZxTWvgxHfBRXesSwWs+fHdCZffME+gKRtOzgTI4
	 R9RGwdkg6JdRx0NXTzP6M8Vt66LoW9f7KUvJWLBEi1e6vjNCbTAib7qAFGa7XYcwRT
	 C7zOJwCF2lrc3cp9CTiPh8MX61F3vIkvCqGi87HicP6sEgy5ZTRrRGVNo6GLjATOGa
	 tcr4xrnVKKYzWCh0mp58UDVumqm7J6zYj3z0uiwKwZHyoWAwoVfq0pl5kICHEy4Ely
	 U6QT6ugl8agei6/pl6TEFgBpLNpj7NXVwLfSLyy0MkzBnEAEeEzamIMLLa0useS2z7
	 klLhyRY0PjxPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DAA50CE0C3C; Thu, 26 Jun 2025 07:37:30 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:37:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/5] torture: Remove support for SRCU-lite
Message-ID: <0d70d94a-7b1a-4ba0-bc2e-d2d11c296894@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
 <20250624161400.867880-1-paulmck@kernel.org>
 <aFvmG2lT65Ido1fq@infradead.org>
 <167ab1f0-ea85-4a0f-8a19-1d74e2fa7439@paulmck-laptop>
 <aF0pBPtzNxmJNWUm@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0pBPtzNxmJNWUm@infradead.org>

On Thu, Jun 26, 2025 at 04:03:32AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 26, 2025 at 03:54:06AM -0700, Paul E. McKenney wrote:
> > How about if I add this to the cover letter?
> 
> Sounds good.  But please also have a very short summary in the
> actual commits.  As-is the commit logs completly fail explain to the
> why, which is the most important part of a commit log.

Will do, and again, thank you!

							Thanx, Paul
