Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82292632
	for <rcu@vger.kernel.org>; Sat, 13 Sep 2025 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722183; cv=none; b=PjRzA/+LzD8PJNnz4HeWBdcIzvoPH6oxwPzJ14X/Lj6BH5nNwt+OX4RN8ohbFDptBRiR8eA+CM6964Qkit1Rf4FAk9DWpzJzioPyVsQTbIvgREzkd5uL+4XVIhamJ794PIGV2mRFd+qZozJoFB2GblV0ta3Upplaqpm7HNDIt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722183; c=relaxed/simple;
	bh=VxsSXWx59/PbkxkYiW4MNE18cTdfGL+gqvmPrXQYGPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kwU+GeXfMYEPzDOK0qJ4bzJpBJnJOz5l53sqavgcEobuOsUklDfT679IyIFeyfq6NT24joazxzK6+5TEMgXT6uKSXjUnLzBreoP/+gtAQuXb3AHpRFO5gIyjtr0nkRJMxb8G49WCDmuPtUK2+nT0gp19hQKP/unrGK6ZyFrIrg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ri+zYwWt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ri+zYwWt"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77621c54731so412399b3a.3
        for <rcu@vger.kernel.org>; Fri, 12 Sep 2025 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757722181; x=1758326981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4qcwx7tIF7ceX4FWdqTaXFiCrpIzKr7ul9F9MwN60k=;
        b=ri+zYwWtyA4vH4dsGZPBWP1LCXqjF95k62taFje+peHmdayulrFcogllOIShjRpJ3L
         VuUX52NlnNsOPqVoIyHxycItmAIzdLdfSYGRYdbx+ANjamyYsIHzvP8dQwCEOwCyd9r+
         vUcnsaHaD/E1xASRq5e425vvIPl3THCs+Z4FwfEjU4VaTm+SCPy3r7eekc9LXAYxPrTn
         jSfLwCGdTUqlVunkFLNZybKG6HzfGNTZQRvU1HaFDduhaWcA6zXodaf9gWTAaPKJdygA
         V2eNic3xCWOoDinFJ/Yr5zkrJO2c5tW0WwFYl2LDUDMEqkTcgkkM+Wd1xYj33qqqar3C
         4dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757722181; x=1758326981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4qcwx7tIF7ceX4FWdqTaXFiCrpIzKr7ul9F9MwN60k=;
        b=P3pxOwF7zfrvNcl0WQaElMclW03muDTPCKsqDLlRdKqVVHvD6S2RndxErldaLAgmlz
         qbPdtJyStB+H7rOq8hAcd1c3LzjKXxuq5lv2yTQKgU2Hh+4buNA5Kwg1tWHQiWZFDFYT
         eDu25PK4Nbe8J4AOMXi3TzEFlpFgeoLyF9YDGzXaBkyGMZVF/7Eyx303ZH1iR4mmCssA
         8THUB0ui+xyqnXA8CR2D2/hn+3BTBpO668Nr8iuIpypFlgzJ+5VSgLYp5FAh1cHBP9Rg
         TNOugOj63Jl2qfCBM5Vzrh7XMrsQeaWqif8ZXR9IjlvRDq2eRWf0Ku9tSNKFabAWaJ7x
         o4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0T+2y8x3wl4scQG7/w6JhvomZUgoUxM6qg60c1ZFXZCdKn+pwEv76FRU+ljiW7/v6by4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDALNiXSb3un1uv8dPvw3cGXlapahoUu0+RYVpYkZ79eRR0c6
	OmIrBAu/SaTohi7JW9sm3WuyElRNVdXeYUqMMdQkszFJKz17DPKZ9PHFXWlKadQB17lEXtor3GR
	Hyajhc7jjw1nW8gb7eQ==
X-Google-Smtp-Source: AGHT+IHS23gulFRPNDYDol1StJlKh3HDBOcLTAfZPF7cXgJccYt3Eih+Wl2Bgx4LCQZX6nkkbvzcr31DF56Mzcs=
X-Received: from pjwx7.prod.google.com ([2002:a17:90a:c2c7:b0:327:d54a:8c93])
 (user=sudarsanm job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3288:b0:252:2bfe:b648 with SMTP id adf61e73a8af0-2602c6246e2mr5853775637.52.1757722180835;
 Fri, 12 Sep 2025 17:09:40 -0700 (PDT)
Date: Fri, 12 Sep 2025 17:09:35 -0700
In-Reply-To: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250913000935.1021068-1-sudarsanm@google.com>
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
From: Sudarsan Mahendran <sudarsanm@google.com>
To: vbabka@suse.cz
Cc: Liam.Howlett@oracle.com, cl@gentwo.org, harry.yoo@oracle.com, 
	howlett@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, rcu@vger.kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, surenb@google.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Vlastimil,

I ported this patch series on top of v6.17 and ran
some benchmarks: will-it-scale, hackbench, redis,
unixbench and kernbench. I ran the benchmarks
on Intel Granite Rapids (480 cores), AMD Turin (512 cores)
and ARM (80 cores)

Summary of the results:

- Significant change (meaning >10% difference
  between base and experiment) on will-it-scale
  tests in AMD.
- No significant change on other benchmarks ran.

Summary of AMD will-it-scale test changes:

Number of runs : 15
Direction      : + is good

|            | MIN        | MAX        | MEAN       | MEDIAN     | STDDEV     |
|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|
| brk1_8_processes
| BASE       | 7,667,220  | 7,705,767  | 7,682,782  | 7,676,211  | 12,733     |
| TEST       | 9,477,395  | 10,053,058 | 9,878,753  | 9,959,360  | 182,014    |
| %          | +23.61%    | +30.46%    | +28.58%    | +29.74%    | +1,329.46% |
| brk1_8_threads
| BASE       | 1,838,468  | 1,890,873  | 1,864,473  | 1,864,875  | 18,406     |
| TEST       | 1,464,917  | 1,668,207  | 1,608,345  | 1,654,578  | 70,558     |
| %          | -20.32%    | -11.78%    | -13.74%    | -11.28%    | +283.34%   |
| brk1_128_processes
| BASE       | 65,018,211 | 65,603,366 | 65,285,348 | 65,103,197 | 232,885    |
| TEST       | 51,287,801 | 52,161,228 | 51,647,807 | 51,509,505 | 277,326    |
| %          | -21.12%    | -20.49%    | -20.89%    | -20.88%    | +19.08%    |
| brk1_256_processes
| BASE       | 15,186,881 | 15,239,120 | 15,210,265 | 15,205,809 | 15,850     |
| TEST       | 20,478,924 | 23,936,204 | 22,754,698 | 22,771,320 | 1,255,974  |
| %          | +34.85%    | +57.07%    | +49.60%    | +49.75%    | +7,823.72% |
| brk1_384_processes
| BASE       | 11,587,076 | 11,851,775 | 11,765,869 | 11,806,007 | 73,736     |
| TEST       | 25,464,757 | 29,176,818 | 26,695,946 | 26,563,116 | 1,012,563  |
| %          | +119.77%   | +146.18%   | +126.89%   | +125.00%   | +1,273.23% |
| brk1_512_processes
| BASE       | 14,410,293 | 14,891,082 | 14,775,209 | 14,793,142 | 114,384    |
| TEST       | 22,918,195 | 29,648,177 | 25,204,321 | 25,128,471 | 1,604,037  |
| %          | +59.04%    | +99.10%    | +70.59%    | +69.87%    | +1,302.32% |
| mmap1_8_processes
| BASE       | 3,164,411  | 3,170,585  | 3,167,590  | 3,167,692  | 2,436      |
| TEST       | 3,516,242  | 3,756,209  | 3,684,585  | 3,698,731  | 68,659     |
| %          | +11.12%    | +18.47%    | +16.32%    | +16.76%    | +2,718.28% |
| mmap1_8_threads
| BASE       | 627,817    | 632,702    | 630,554    | 629,281    | 1,764      |
| TEST       | 541,202    | 554,097    | 549,104    | 549,896    | 4,257      |
| %          | -13.80%    | -12.42%    | -12.92%    | -12.62%    | +141.34%   |
| mmap1_128_processes
| BASE       | 30,303,429 | 30,736,686 | 30,466,107 | 30,343,821 | 174,985    |
| TEST       | 9,749,426  | 9,893,331  | 9,823,701  | 9,857,157  | 52,125     |
| %          | -67.83%    | -67.81%    | -67.76%    | -67.52%    | -70.21%    |
| mmap1_256_processes
| BASE       | 7,496,765  | 7,546,703  | 7,528,379  | 7,543,246  | 21,465     |
| TEST       | 10,868,119 | 16,947,857 | 12,695,418 | 11,608,083 | 2,157,787  |
| %          | +44.97%    | +124.57%   | +68.63%    | +53.89%    | +9,952.34% |
| mmap1_384_processes
| BASE       | 5,629,206  | 5,856,927  | 5,758,347  | 5,733,892  | 85,930     |
| TEST       | 12,053,514 | 13,635,555 | 12,966,975 | 13,283,450 | 606,325    |
| %          | +114.12%   | +135.49%   | +112.89%   | +104.26%   | +2,855.57% |
| mmap1_512_processes
| BASE       | 6,959,199  | 6,996,383  | 6,975,912  | 6,974,353  | 15,446     |
| TEST       | 10,197,814 | 12,029,690 | 11,458,180 | 11,381,726 | 534,690    |
| %          | +46.54%    | +71.94%    | +64.25%    | +63.19%    | +3,361.67% |
| tlb_flush2_384_threads
| BASE       | 2,953,477  | 3,021,464  | 3,003,512  | 3,014,264  | 25,525     |
| TEST       | 2,231,417  | 2,526,876  | 2,408,368  | 2,411,121  | 115,773    |
| %          | -24.45%    | -16.37%    | -19.81%    | -20.01%    | +353.55%   |
| tlb_flush2_512_threads
| BASE       | 2,499,486  | 2,542,966  | 2,520,278  | 2,530,049  | 17,161     |
| TEST       | 1,707,641  | 1,714,524  | 1,708,951  | 1,707,713  | 1,877      |
| %          | -31.68%    | -32.58%    | -32.19%    | -32.50%    | -89.06%    |
| mmap2_128_processes
| BASE       | 29,754,984 | 30,313,146 | 30,010,106 | 29,897,731 | 218,812    |
| TEST       | 9,688,640  | 9,750,688  | 9,710,137  | 9,696,830  | 23,428     |
| %          | -67.44%    | -67.83%    | -67.64%    | -67.57%    | -89.29%    |
| mmap2_256_processes
| BASE       | 7,483,929  | 7,532,461  | 7,491,876  | 7,489,398  | 11,134     |
| TEST       | 11,580,023 | 16,508,551 | 15,337,145 | 15,943,608 | 1,489,489  |
| %          | +54.73%    | +119.17%   | +104.72%   | +112.88%   | +13,276.75%|
| mmap2_384_processes
| BASE       | 5,725,503  | 5,826,364  | 5,763,341  | 5,765,247  | 29,674     |
| TEST       | 11,682,353 | 13,720,566 | 12,269,665 | 11,776,228 | 877,060    |
| %          | +104.04%   | +135.49%   | +112.89%   | +104.26%   | +2,855.57% |
| mmap2_512_processes
| BASE       | 6,959,199  | 6,996,383  | 6,975,912  | 6,974,353  | 15,446     |
| TEST       | 10,197,814 | 12,029,690 | 11,458,180 | 11,381,726 | 534,690    |
| %          | +46.54%    | +71.94%    | +64.25%    | +63.19%    | +3,361.67% |

