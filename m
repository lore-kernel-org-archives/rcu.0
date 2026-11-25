Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616283;
	b=E7q4AbTVs1pBwuzYZdUseQDQxGS5kjHYxI8MnOhy3cn6afHFBrTWFUBxhO8eftMZCovy
	 VGdqXRC8UAbdEMs3Q567+rRCBrL5HgKMoOWvYr9+jZ2w6WRV10alsbZriECWR08z1Rjxk
	 NSZsc8QQc62YQN7oD6baslJmQm235a8FMERbb6Mmm/QG7STdY0o+3/M8U807j7vwgyzPC
	 XvtIaOXHtbCfjvvKIktpUBaS3HMbzSAT7gMfq6e2HzuPMf95VBV5oUODUVJe8d4o7gJFk
	 1QUD5bJpYjbzsKh7TjT6y8GYzo028V75koXMzoEIIK5IlvwTDDJn+PE2Hm8oK0xlpYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616283;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cz6q/stH72VoxzJvriTDyhchEoMpXYcJk6FPeliPcts=;
	b=Z3mSU+PBCSBfcXT2fTtxDr9VCZoUpDtnSdwj/kg75Mj7mW1foD8i9hSabx0gBrBS9H9G
	 +ITO/szHIZ0kXhuM8byTFEcf4Uo9lDOAxI2Bm8wO3HM+E7bgQBSVk2d27AG0wgBDHA5uR
	 6TxR/RBqHW6Ubfu779Sy0jTZU426NWM8vqenYCLbZ82rQJEhKn0HguPyIg94XXMWZbP2M
	 NQfFEQ2OSJ8NuQ/kMSM1P5qYtKtMitffM3pSp5wELUi4TarwSOm3bZDxA7fqS0+lM+qaW
	 9/4Yp7M/xoX1pD6ezI3CfvRqByFtUtEiarnixzXXd3B3mK3mNx8EA560QSBtPmFqCrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	dkim=pass header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=TACvlVp5;
	arc=none smtp.remote-ip=95.215.58.64
Received: from mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED5606A321
	for <rcu@vger.kernel.org>; Wed, 25 Nov 2026 14:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67ED5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=TACvlVp5
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CCa6MLPgSfC0gSv1/TwQ2U1xBZ9d9xJFhl1N8rsJZyk=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795616280; v=1; x=1796221080;
 b=TACvlVp5XJlw0i9zLKjIX6ViIxnQhY68D8+L3z1Qk9/0o7khe0XjfS8bdJNWYmDr35uQposF
 yYsf6F31ATQ9+3UIjLRzQoFdRiAtcq1qSzz/NXX1aEXi0pA8jLcetAz2WdvRzoBdgsXmbx322JJ
 rLod3cW9A+9PU+3UkuLXOnmoqhxQ/A+KhYiLOr+DZy6VnSIoauyZYYlVt+wxM55jEqIhQQl0kG+
 +4lnyRoaeF+0s1NiCSJLOG2svU0H706jcGj457voz4sd8Ie9Z+R29r8Wf94kAE6O2rpm2ZOVV6L
 8e13TDpVgjeQ7WR8s6BlQ+oKuyoWNoE7zvOUEiJUFxnxg==
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5990fbd04151478c;
	Wed, 25 Nov 2026 14:18:00 +0000
X-Mizu-Trace-ID: 5990fbd04151478c
X-Migadu-Flow: FLOW_OUT
Date: Wed, 25 Nov 2026 22:17:52 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Bruce Song <xiongwei.song@linux.dev>, alexs@kernel.org,
	si.yanteng@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org,
	rdunlap@infradead.org, paulmck@kernel.org,
	linux-doc@vger.kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] docs/zh_CN: Add RCU/whatisRCU.rst Chinese
 translation
Message-ID: <awbuEAiOpfpfov2b@wyuan.org>
References: <20261118131636.5131-1-xiongwei.song@linux.dev>
 <20261118131636.5131-3-xiongwei.song@linux.dev>
 <09ef3d3d-0e68-49c6-a6a2-c754104ede9e@hust.edu.cn>
 <946792d2-4241-445d-820b-301a570ee2c3@linux.dev>
 <awZZVV3BlovD-xNf@wyuan.org>
 <9d2b25e4-c5a0-4ef0-8698-1a622d05223e@hust.edu.cn>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d2b25e4-c5a0-4ef0-8698-1a622d05223e@hust.edu.cn>

On Wed, Nov 25, 2026 at 10:00:26PM +0800, Dongliang Mu wrote:
> 
> On 11/25/26 11:43 AM, Weijie Yuan wrote:
> > On Tue, Nov 24, 2026 at 10:23:50PM +0800, Bruce Song wrote:
> > 
> > [...]
> > 
> > > > > +:翻译:
> > > > > +
> > > > > + 宋雄微 Xiongwei Song <xiongwei.song@linux.dev>
> > > > > +
> > > > > +:校译:
> > > > > +
> > > > > +.. _zh_cn_whatisrcu_doc:
> > > > 
> > > > Please double check all the references. If one reference is not referred
> > > > from other places, please remove it in the translation.
> > > Ok, I will do that.
> > Let's make it a rule or instruction, shall we?
> > 
> > I didn't find any specific rules for label usage in doc-guide dir. (only
> > no more top-level label on list) But I suspect there must be unused
> > labels in English docs.
> > 
> > We either:
> > 
> > (1) make it consistent, i.e. keep adding unused labels.
> > 
> > or
> > 
> > (2) check usused labels and do not create new labels for it.
> > 
> > 1 may be easier for manual translating jobs that you don't need to check
> > every label manually. You just need to add a '_zh' before each original
> > label. But apparently this will create tons of unused labels. So, no?
> > 
> > 2 may costs more attention, but I guess agents could handle this
> > nowadays with proper prompts.
> 
> 
> I prefer this solution for some reasons:
> 
> 1. If I understand correctly, Jon asked us not to add useless labels in the
> translations.

Yes, true.

> 2. The labels in original English documents may be invalid, we should
> not inherit them blindly. Only if you find some place refers to this label,
> you can add it to our translation.

True. So I also hope that the English documentation includes a note (if
there's no such): do not add unnecessary labels. This way, our new
translations will not be added in correspondence with them.

I will also try to troubleshoot unused labels in English articles when I
have time. Sadly, Sphinx does not print out warnings for this, so I have
to grep them.

> > I forgot to mention this thing in Daniel's series [*], shall we mention
> > this now, or send a RFC patch after they get merged?
> 
> If it is not merged, comment now.

Sure, will draft soon. It is expected that his series will not be merged
quickly.

Thanks.

> > And also, add a rule for English docs that _do_not_ write a label which
> > is not used? This will make our job easier.
> > 
> > [*] https://lore.kernel.org/linux-doc/20261119041009.63651-1-danielmaraboo@gmail.com/

