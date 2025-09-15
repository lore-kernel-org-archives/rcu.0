Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13596305E09;
	Mon, 15 Sep 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938405; cv=none; b=QTSjEcf3bBhEIIEmWcyzIE6TOcPRMD4WRXcQ/+NEcotq/8VyGpkE3pLiwmAh9ACpgVX3IK5OeObHOGrKEL2zB3/Qy+wQBw2ejiX1hDYMwN2e/bZYqTTHz+RIT5TCMSoJU0q0VR6n4UDTf2F+T3qiuKlmDduJzqGDjvbviKWQZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938405; c=relaxed/simple;
	bh=N+eJ0gU44hVx/MW9LCq46yXd5OHmuJCxQYNhv441Ql8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0na/+DuDvLNPKw0WXVpCGWkH7T5lN1l1XB6UrmGfS5GIWyDmMyosrajW5Okf6V0Ur2lE0uh8PbBKGhJgaTZNP8xEpnn/ph2hJxoVCoLUtKpYklKocOCYUK2JGY0jZdcLtEvnXj4O4eIevsJTxaDGDtJ9InbR3o2Yaj4yMuo7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSR2ZDJl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSR2ZDJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE01C4CEF1;
	Mon, 15 Sep 2025 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938404;
	bh=N+eJ0gU44hVx/MW9LCq46yXd5OHmuJCxQYNhv441Ql8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DSR2ZDJlBr3Wz4wRY+2/aAxWZSLSTpc8cbCBn919mwyiZSGq1+6EYpGqVA0cI+Kil
	 TqjE5KE/mMgstLFFBbXddlGj4l6x0jJHRyg7M1GG3aIJRnoFBIhCV+nlrbeNcU+v5H
	 WJA3Vxp4AgCNsADMhg5o0p3u0JmoXzKaC6NGkjJoj2nx5eBd5Vmc3Y8kRVw9DBEg5+
	 FXC/nHThtqA0WnchXGu1Nh4DWBTgIfu07n1mJBahrb5OVDx499jSGkLvm27bV03WcV
	 TXciRp9D5W24P+w8Ecf/7m3/ImM/yiJbBKA35s/3Xj+Qom7LlmXT4X3NWdfqvQJc5i
	 I5C8tnFC0At2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C3D2ECE1105; Mon, 15 Sep 2025 05:13:23 -0700 (PDT)
Date: Mon, 15 Sep 2025 05:13:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jan Engelhardt <ej@inai.de>
Cc: Sudarsan Mahendran <sudarsanm@google.com>, vbabka@suse.cz,
	Liam.Howlett@oracle.com, cl@gentwo.org, harry.yoo@oracle.com,
	howlett@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org, rcu@vger.kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev, surenb@google.com,
	urezki@gmail.com
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
Message-ID: <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250913000935.1021068-1-sudarsanm@google.com>
 <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>

On Mon, Sep 15, 2025 at 09:51:25AM +0200, Jan Engelhardt wrote:
> 
> On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
> >
> >Summary of the results:
> >
> >- Significant change (meaning >10% difference
> >  between base and experiment) on will-it-scale
> >  tests in AMD.
> >
> >Summary of AMD will-it-scale test changes:
> >
> >Number of runs : 15
> >Direction      : + is good
> 
> If STDDEV grows more than mean, there is more jitter,
> which is not "good".

This is true.  On the other hand, the mean grew way more in absolute
terms than did STDDEV.  So might this be a reasonable tradeoff?

Of course, if adjustments can be made to keep the increase in mean while
keeping STDDEV low, that would of course be even better.

							Thanx, Paul

> >|            | MIN        | MAX        | MEAN       | MEDIAN     | STDDEV     |
> >|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|
> >| brk1_8_processes
> >| BASE       | 7,667,220  | 7,705,767  | 7,682,782  | 7,676,211  | 12,733     |
> >| TEST       | 9,477,395  | 10,053,058 | 9,878,753  | 9,959,360  | 182,014    |
> >| %          | +23.61%    | +30.46%    | +28.58%    | +29.74%    | +1,329.46% |
> >
> >| mmap2_256_processes
> >| BASE       | 7,483,929  | 7,532,461  | 7,491,876  | 7,489,398  | 11,134     |
> >| TEST       | 11,580,023 | 16,508,551 | 15,337,145 | 15,943,608 | 1,489,489  |
> >| %          | +54.73%    | +119.17%   | +104.72%   | +112.88%   | +13,276.75%|
> 
