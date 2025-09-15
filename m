Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E532E3397;
	Mon, 15 Sep 2025 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923066; cv=none; b=a8gmFL5La3uE+KUOOkpaNOlGHlRLMOBemz0D8qUgqcI9fd32q4A97F8d8HSm6LrVCM67kbHffhbSBEZF9IbY633fDJP5TK8kNhy4W+rTs0abMrdNhXkU3ArRQpCjT/ch5za3DfM1GoImQLeX32GDs4QgKEa6XNapRC/iRdGTkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923066; c=relaxed/simple;
	bh=q1tMMGYP7r1Z2f8ud+W8eBZSvKk8A6um8wiaX2PZSVM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XqPPPD3VjRkmz5f7nmRDKUQDY5I+FdRlRz4OHpgHnFlxzHqYCDxErObe/f/uDEFGvdxcuBgwYvveJ6qZtBUEGCzngcnCvxJ0zDikHoALPBS38eMHSYma+Cy0vNcsj85gZ6tZohSuxw5kkbeyeig7j6wab36cz0opJRR8Q8XFFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id A5C131003CDBE2; Mon, 15 Sep 2025 09:51:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id A56C5110020B40;
	Mon, 15 Sep 2025 09:51:25 +0200 (CEST)
Date: Mon, 15 Sep 2025 09:51:25 +0200 (CEST)
From: Jan Engelhardt <ej@inai.de>
To: Sudarsan Mahendran <sudarsanm@google.com>
cc: vbabka@suse.cz, Liam.Howlett@oracle.com, cl@gentwo.org, 
    harry.yoo@oracle.com, howlett@gmail.com, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, maple-tree@lists.infradead.org, rcu@vger.kernel.org, 
    rientjes@google.com, roman.gushchin@linux.dev, surenb@google.com, 
    urezki@gmail.com
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
In-Reply-To: <20250913000935.1021068-1-sudarsanm@google.com>
Message-ID: <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250913000935.1021068-1-sudarsanm@google.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
>
>Summary of the results:
>
>- Significant change (meaning >10% difference
>  between base and experiment) on will-it-scale
>  tests in AMD.
>
>Summary of AMD will-it-scale test changes:
>
>Number of runs : 15
>Direction      : + is good

If STDDEV grows more than mean, there is more jitter,
which is not "good".

>|            | MIN        | MAX        | MEAN       | MEDIAN     | STDDEV     |
>|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|
>| brk1_8_processes
>| BASE       | 7,667,220  | 7,705,767  | 7,682,782  | 7,676,211  | 12,733     |
>| TEST       | 9,477,395  | 10,053,058 | 9,878,753  | 9,959,360  | 182,014    |
>| %          | +23.61%    | +30.46%    | +28.58%    | +29.74%    | +1,329.46% |
>
>| mmap2_256_processes
>| BASE       | 7,483,929  | 7,532,461  | 7,491,876  | 7,489,398  | 11,134     |
>| TEST       | 11,580,023 | 16,508,551 | 15,337,145 | 15,943,608 | 1,489,489  |
>| %          | +54.73%    | +119.17%   | +104.72%   | +112.88%   | +13,276.75%|
