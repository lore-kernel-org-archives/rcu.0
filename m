Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3FE26A09B
	for <rcu@vger.kernel.org>; Sun,  4 Jan 2026 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524115; cv=none; b=jACC2IFVPnbpITpXd/Nsao2OMQMFHjw4ZVRCrLxTvn4gpIPqSU5KxJjk88kImqFetXqgAwOLTx85KYMLQHOHpXZujkEdJ5sFOsdMYtK8/HJbSfAeumCjWyfJ+BZNCHNEr30wL32lyHZ9DTJBDpIpvFzUnTWEDO80hOd4v5IAdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524115; c=relaxed/simple;
	bh=N2NFBJBc+fcjC7P3jRiEoizwCrgAlI+5FVrpTi06HnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9+Ysq2+9f0yIYp5xx4JNkb3PXH6OV05xoTvMb0dK8tgm1rqZ4aCvGvZVWPx117LSyo2CclCzrlyMh03nC9XMeIPisrfd3W01apGy16aURCALFZl1LCKkLKU0ZHQS2GA6sRj9AgZlNmwKUbM9IevMVmfK9/LB9ljn/XoFu+oJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSaH8jDt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSaH8jDt"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee1fca7a16so114195611cf.3
        for <rcu@vger.kernel.org>; Sun, 04 Jan 2026 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767524113; x=1768128913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KbfO1i69mPL+mrubhr+uxnSp4Z/WqGGTqSL3K9pfVA=;
        b=WSaH8jDtyFssphex8IjFN8RUIj3BM7mNc8Z5CzL65SSPLjaK9CanVbnzfNEWflWXRk
         TVW1NcNvAbYluqkysN71FCtjFaqcNq1i2JBZ8apreTnr4r+LBJKhnRv5TNC3WMphy2XM
         9GbwTFi03WEe/mFzbUI5+ntAc07GImvlyPOxpz5mEN7qb/D+fsJuCIuO2eiM+PlumW4Q
         JhKXnQ8tt9KTV8INbYXkWxbmDGcKyZ3UJtv3lVZaewYzSa4w+7Qxkglrl6Um0aeW0wBh
         i39hlqEnwOYQFobnRkjBeAL2v+Qwq+11nCxDHcLskJf4/7gKK1qQ9qM4U8PYMLcYO6YW
         YrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767524113; x=1768128913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KbfO1i69mPL+mrubhr+uxnSp4Z/WqGGTqSL3K9pfVA=;
        b=AaS23pr3HzF1iG4cnjhxcRYN59lqR4A+eMQj7pfxQw9EYelOSJmRsLRwwPEQa8j7gD
         rNwlfcBCn7d/+P9GJsbW1chld5w5WgC1W4bxtrbHySMf7ZCqj5wZ0pgoUFWJalGinQYw
         0/R2JjZdidi8Wr0edRPTD3JOkxDpAUk5U9t86RiaDFH5hWo1zeiUtMLfNh20g/Eal1/K
         wxR6S+nEn4Gkl9LLd9d8FC2E2QrkMjwJGdX+tr7NDCJllm2VT5LLonhXsF3dO1q+1zjO
         C1aiq84NGSOJAGT6cpRrf+mb1vg/+2eem6QjXf8XfVsNDkyO7vSAD4jrooLXv5eqAdzY
         hDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgfDyJ0NEY0kcsx/IATBPPTWOGTLifECRZnPJRIs4PBeqp3Z7tatKT1ALoYoCybBCtQR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVop106m+S+8v4wXhSSrukFQ85fU+FV/NvaN7NJRVex6Id6Tt2
	oCjyT0E7VVoFC9CdaLZwePkPjUAhnz8UOnEdSgnZJ6I8PAr+COlT+5Tl
X-Gm-Gg: AY/fxX5N9J4PQPIJxXFzKP53llAgQEZdDnmcb1KamKQj0fgXMMLl6gZjl86KcIl2iyA
	Y+NMLdRQ6RnQfWnwyJ2lTfFq7o3B6jNv+GhD6LHNmRvzuqghxfLERUOC9voYxZ+d6u3z1V6jsmK
	XoczF2/6kpOXsixhEmNFdigFIIYQGOfx0loEdrnAD0vRKTagJBMXfPzzEXyZPB9AlYlv7V9H9kv
	Shoeyji3Xed2fiQwUBtCeKJ7AMII3a5MPcKVhoqukbmQ0Dfi52g702xBSMBmZL0JKiafTikAMJu
	PYMV7xOO9hXuJdfwKmU8t7hVPeVoanerv2UIoqKWbqX/HO9jzG78GSMtgUMfEB09O0uzDCFTA8z
	kLsLpD2jVLyIeNIQyCuJa9Zt3jVsmLNeE/hSpd5+pK60HkgWuXY6tydAVDHh1qMO8wv4UFUf9F6
	2XjeW44opPoIZ2phrTkkHiu4N44JNI317OzgOno9VyulogDXmCLLPfmbcOGa7xwzGjwq/T1d6AL
	9AuD8msR+cyXlw=
X-Google-Smtp-Source: AGHT+IE+qwfHcvZu7g88+7aXL9FHzacq6d3LEZhX6euRl5AyR5Pc+4qPOQQsxUfq1v6m7ClnOJ6rtA==
X-Received: by 2002:ac8:6f11:0:b0:4f1:aba0:9329 with SMTP id d75a77b69052e-4f4abd15f01mr790228741cf.33.1767524113133;
        Sun, 04 Jan 2026 02:55:13 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac563f66sm320455761cf.15.2026.01.04.02.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 02:55:12 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id EAF20F40068;
	Sun,  4 Jan 2026 05:55:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 04 Jan 2026 05:55:11 -0500
X-ME-Sender: <xms:D0daaZIERhJn8aaRjBZo5bo1jhie88tt-eaVp3V30TUvnVzBVsSWSQ>
    <xme:D0daaUlC6p1FjltqbYLOoZ1bhNJXQvHt5oU1QU6gmryamk3byUzS-JsBo24KgpkXI
    942nNYgB5PqVXIpW_6ayYCeEwzAGJC55HlnK2PBSIbA7ymTTDfCgg>
X-ME-Received: <xmr:D0daaSzUwrHxYhLG6pjx32HKs4moT8sQujJyilhCpEINflN0il_x4uU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelgedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhu
    phgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshh
    htrhhiphhlvghtthdrohhrghdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtgho
    mhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoh
    epmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhm
X-ME-Proxy: <xmx:D0daaetRzq7P0MTTgEgo4pY9Jb00LEjevEin4sK22TaQCdzlw9i_Ew>
    <xmx:D0daaUFz-XqgDF1gtdVgCaEm4GMaavgVzPzIB68S98n-hA2BqC_dNg>
    <xmx:D0daaU5IQG4D_BIwQ-AS6fAxxmFpR3CKG8qA-FFgHoFUhgrPY5x8XQ>
    <xmx:D0daadzn5xiHLKo5aozws4kIlEdyPFdOwnUU2s9Th9mOhiQll4cYpw>
    <xmx:D0daaS3AkC-7G6i1pZ4FylF_eeHBH3gkwoN-3vShFve9TB_6IYQ6pl7q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 05:55:11 -0500 (EST)
Date: Sun, 4 Jan 2026 18:55:09 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 0/8] RCU updates from me for next merge window
Message-ID: <aVpHDWWiL1huoSBT@tardis-2.local>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>

On Thu, Jan 01, 2026 at 11:34:09AM -0500, Joel Fernandes wrote:
> This series contains RCU fixes and improvements intended for the next
> merge window. The nocb patches have had one round of review but still
> need review tags.
> 

Queued for more tests and reviews, thanks!

Regards,
Boqun

> - Updated commit messages for clarity based on review feedback
> 
> - Testing:
>  All rcutorture scenarios tested successfully for 2 hours on:
>   144-core ARM64 NVIDIA Grace (aarch64)
>   128-core AMD EPYC (x86_64)
> 
> Link to tag:
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/tag/?h=rcu-next-v1-20260101
> 
[...]
