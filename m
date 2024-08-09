Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116B195B18;
	Fri,  9 Aug 2024 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211367; cv=none; b=hQbXobps4HG1iRS0VRgeZlENgTsUFj//B5PZrcSN59tlE1J6HG8lqbnL0y13UiSpN6YqOAhUB8mnG4tigsFO10dkAgyu10XPHtZd3axN6T7QWE2G/zlfh/jXgC9O+RevsTYAY5pnzHE6w8Y2cCPlGGtMyP+S7spOhVuEduUf9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211367; c=relaxed/simple;
	bh=C+gIFlyGMCduKmWNIBw9dRuDUg+MBEYeouMi/So4pD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxaVMLLxSoA5JFZrK2tkHnJ8X0NxQmfOp9+3pzu6FTQcrpM1DZjG3Tn9fVKq38RQ2DZqPR/4ANNN19ijZISKKKpRAQfYF+/ii9iZsqZB9x904siAb96e58gPFwGbeNVTPz2dQafo4s0eMQrVBDoHG3C3i6p78JvmxKgbIN97Rd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DVRJMbD/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DVRJMbD/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=47NW2XTBLKy+JoGemROVoOjIno1OsPS387sub0zUsJQ=; b=DVRJMbD/d+b+ri1hqUPwI1BYpw
	AtUaI0DTXrCLJDf3Bk1fR8Cpn01NZsD+WFKzSgEtiOC5a1cl1sUQu7L0IkTfIFLN6gwMVEkjAoxIw
	LL5b24dTLZawDUUmTiznYYrKygtTy+roU9BMpeXIjeF1+dODK6XGAVEWQctsLYj5dzKo38vDfW362
	0L/VMRKc/xgE4Cj1SlYpMcVGF8vHMAxHZfMOXNX96MRo78C3GCrDvT8ChpVp+2qOkMOtD8yAznFMB
	hy6mr+fZid/vjXCptuqgrV5vD7+mAZ4970PNQNiX+JJnvac7b9WKdUtaZNWcg4CTW2KPA8fppRte/
	2/ovtxGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54196)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1scPzC-0005zC-1t;
	Fri, 09 Aug 2024 14:48:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1scPzC-0006Ah-U5; Fri, 09 Aug 2024 14:48:54 +0100
Date: Fri, 9 Aug 2024 14:48:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Will Deacon <will@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
Message-ID: <ZrYeRmn920CACeCa@shell.armlinux.org.uk>
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
 <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
 <ZewycILled+mZhwe@shell.armlinux.org.uk>
 <20240312221440.GA29419@willie-the-truck>
 <ZfDZolTDQa76hhaS@shell.armlinux.org.uk>
 <20240313003244.GA29568@willie-the-truck>
 <ZfF4t74OD4CgVaGV@shell.armlinux.org.uk>
 <f15aea08-8daa-4994-a8f6-be0461b06539@nokia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15aea08-8daa-4994-a8f6-be0461b06539@nokia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 09, 2024 at 03:37:38PM +0200, Stefan Wiehler wrote:
> Unfortunately I'm don't feel qualified to contribute to the discussion
> on option 3. Russell and Will, would you be able to spare some time to
> drive this further? Otherwise I would propose to make a decision on
> going for option 1 or 2.

Highly unlikely that I'm going to have any time what so ever as I'm
undergoing a series of operations which are affecting my eye sight
(over the next 3/4 days, I have only one usable eye while the vision
in the other settles post-op.) I have little idea at the moment how
this is going to pan out, or how long I can spend in front of the
screen.

Worst case, it could be well into September before I'm able to resume
any serious kernel work. E.g. if the brain is unable to resolve the
3D imagine from both eyes next week. Then there'll be the second eye
to be done at the earliest 30th August. Then there's waiting for the
vision to settle in that eye. Then there's working out whether I
need sight correction to see the screen and possibly getting a new
set of lenses for the glasses.

So... I think it's best to count me out on being able to solve this
problem.

Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
