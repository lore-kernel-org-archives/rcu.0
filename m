Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290872C0F75
	for <rcu@vger.kernel.org>; Sat, 13 Sep 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774115; cv=none; b=Ri/a1iWtRPxChkwBkfrVEdGWbXbOdELXc/b/Dyw8J1ylP4LSmcz4x/N9f0FQ02EX/cpgGT7bjrYUTPlQ2qewlB7r7Vr7+djzdFtK0g/VQZmc4GuoZ1c4tLLtN69j4nwnWQsDSVIgpSHlSVbwyPPrGLBmBirYaZCc5Xdn+rgY1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774115; c=relaxed/simple;
	bh=BDUX9YlCgL1zi6slcpLNU7LLkO4E+t3sycYAa7g+gzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQYmHT3EySuPEBSnKCd5r2wi3TOcTNURpTaUw9qYQPHDwkK6c0XydHjGsZCnkL7eWWsgpiDPv7Q049t/GhIcBwgRchBMf3uozJBeocytt01d8JjAIQhkbpE1hKg9ElFKusCz51D9aqT/vjNgbHWjljRwdXtTeYn872xnTx0OF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlkxxIC2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlkxxIC2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e957ca53d1so127027f8f.0
        for <rcu@vger.kernel.org>; Sat, 13 Sep 2025 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757774112; x=1758378912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fiXrarRSR0kdAO2K4VRZ44JDkzpu5N8uZFGaP00hf0=;
        b=TlkxxIC2X7r5jXx/y+ztZkr2LBQJ29qwqF2FJDA8qww3dI9e7n+8MSXw8GLQBk7itC
         vIk3FCRUwH92oKVXlfOaiKGE5X81haNEnzZmiON4oGOloCuZBgJAAwtae+Fnu0g06Nqg
         vkjP0sXUlrwZ6UiY/nCfRkn73RdNTYYugtNa43OpX7sMmk/LJzgvA842g5HcIkGM5nXE
         MQ7UB2ZE2R02wM6Cy5W4BMpclZxSCjsMS9LFh61bkuE5eo4Wk02FIpBNT52NQOHnaWNh
         d48aY5U4UcJVROgf98xd8ktB8r4FocgWYQDjHJw0uKs966+Qj6BNHDCA/Hgg/+H7ChCU
         R0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757774112; x=1758378912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fiXrarRSR0kdAO2K4VRZ44JDkzpu5N8uZFGaP00hf0=;
        b=O6FTtJalzSnYCqxeV23aHtNHQyje1PndStFRc/1iXcBViNcA3DHVfmBQKFHVZEwU88
         WUgdAMQB+LtG/oSnw/VbFmigJjHu8gHRbuePco8L7Mb+57fKDls5zOFWJaVm0nby27V4
         9fFZvZx/ms5Yhs93Jp2Z1rzxlxLcoVHD6+HV5xh3kIqWW7F8PL+azHmevRadrbFdKv4W
         h02cQbxcwlOfJeMQX7VtgWBEHZCml+zX0WsgpQhknNgRua32699f9e7WHg9XIBWrxOGh
         wsasL0nWuoY1L7SselhzNgiWASWcRe92BBUyUNGAFxGzLdfvIzElZkECFoJ11ux8qF2x
         e5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWrBq19g8IWPiIEi/tfMhCIFMl2EcKvfZUFhpzcBqZMTeSSWYPabfcPyOPH6VyRC5oXzv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6jvbgBGCU9HF9j/U0M8Wai9x3VXSxHLhpl4wKnTBZEitv1IK
	VjDRa15E5lUzBNgtiZnoADu5jlUA0wftoBSJq1PybBAiaMxlhtvu54mM
X-Gm-Gg: ASbGncusw0GBqI/T6A7AO0PVK2GIfvMTmmvALtCuB4yx8QNRqxS1O6lqaDttWgtDcZh
	4mBWvKf4KanOoy1hxXIS4gBHhq4jP1CYzAN7JqFz8SkrQ5pbIBSDyEDtCdzprQ5qXnx3/Cir+Fc
	rSj46LRMFYkz+amPxvMCwhLwHAk1aWcDiH5LThY0A/1+SgGa1sOzkweIkr/WN3HPVezFEKJunqQ
	MAERO882CPnZ9Vv15U3csFcKdcLHfRjoRAw5S33hlzMcYmhMgBTX/of39DWC9JhcAsfgf9+RQaV
	btKtWuzAwnRAtSHaw25iXaounQUxSFqw3mXpaKZCpuxGC8yrSow+9SgmW4H0SjOOfr5/pd4lJvz
	6G1CYdTFDXKbOb4T2X/5e8brVOxZ/oPTHtKXOMoQEhawT+APq+hrd5CEzjBzu3fUJ1Te46A==
X-Google-Smtp-Source: AGHT+IHhpBBCovNgxAqBRlSFfJutUHogP+FA8KmrQiU/CxNP8LHdbv9lBhG/X6uQAQCakmX95bODlw==
X-Received: by 2002:a05:6000:26c6:b0:3e7:4c93:18bc with SMTP id ffacd0b85a97d-3e765a092c1mr5272349f8f.49.1757774112195;
        Sat, 13 Sep 2025 07:35:12 -0700 (PDT)
Received: from f (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f29174de1sm15209675e9.2.2025.09.13.07.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 07:35:11 -0700 (PDT)
Date: Sat, 13 Sep 2025 16:35:03 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v5 01/14] slab: add opt-in caching layer of percpu sheaves
Message-ID: <ja3gd6bdckiuanm3xu4hszpjm7euvffm3k7tmu7drh6mdel7m6@oyr635vikumk>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-1-b792cd830f5d@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723-slub-percpu-caches-v5-1-b792cd830f5d@suse.cz>

On Wed, Jul 23, 2025 at 03:34:34PM +0200, Vlastimil Babka wrote:
> The sheaves do not distinguish NUMA locality of the cached objects.

While currently sheaves are opt-in, to my understanding the plan is to
make this the default.

I would argue a hard requirement for a general purpose allocator in this
day and age is to provide node-local memory by default. Notably if you
have a workload which was careful to bind itself to one node, it should
not receive memory backed by other nodes unless there is no other
option. AFAIU this is satisifed with the stock allocator on the grounds
of running on a given domain, without having to explicitly demand memory
from it for everyting.

I expect the lack of NUMA-awareness to result in increased accumulation
of "mismatched" memory as uptime goes up, violating the above.

Some examples how I expect that to happen should this get expanded to
all allocations:
- wherever init happens to reap a zombie, task_struct and some more
  stuff may be "misplaced"
- even ignoring init, literally any fork/exec/exit heavy workload which
  runs on more than one node will be ripe with mismatched frees as the
  scheduler moves things around and the original parent reaps children
- a process passes a file descriptor to a process on another domain and
  the latter is the last to fput
- a container creates a bunch of dentries and whacks them
etc.

In all of these cases getting unlucky means you are using non-local
memory, which in turn will result in weird anomalies which suddenly
clear themselves up if you restart the program (or which show up out of
nowhere).

Arguably, the fork thing is a problem as is and *probably* could be
reduced by asking the scheduler upfront where it would run the child
domain-wise if it had to do it right now and making fork allocate memory
from that domain.

But even with this or some other mitigation in place there would be
plenty of potential to free non-local memory, so the general problem
statement stands.

I admit though I don't have a good solution as to how to handle the
"bad" frees. Someone (I think you?) stated that one of the previous
allocators was just freeing to per-domain lists or arrays and that was
causing trouble -- perhaps this would work if it came with small limits
in place for how big these can get?
