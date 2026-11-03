Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696241;
	b=h6Xj90BpEp0MY6whCXCmx5kNLVc/crKMdZ6y0qXQzYHC2IDqhLFk5z4Zbo2TEI8ySVpo
	 CLHsIKHZeUtD+pUc5jLZ6AzfdCPsTCBj1iZr/c3LcM3exRweq3M/phwskCm5zpUkhU6RN
	 74RDt4lk8J/g12lTsvU7oNsqypI2S+Ind52pLvjmkWJ/TxVv5OxIL1/SVSyEX+0rq6RS4
	 dAwVdM5BOzUN1VskDFeM0Ywh7WnkoersdA3B8xu0cMwiTPsVKMMxPw5F9Piy8QM0ECyHc
	 asKSQV0vmglyDzJ5t4dt4NpUcC9Ok6rjIxO1zBy+lue0Q5EcnwtgOY4bArBPtHq8gmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Er/6bqz2N7+83QaIQ6D94RNvY6ZoeYk2XRlSx4xqVLM=;
	b=X9MWd+RccJvxGmAV761/jD23R6u+AwdhwX/+BP/pJKIPp6jMPxXm/9HOkaRLgwGb3oFs
	 TcppdadJLjRIwBBIqHCYUw9xCuuDFy8t0/K8RD5rdbdR8I0+sO+hBD9+ivvqlq1aKeMXN
	 pSj047JBLYBhsopz9uMD11ja96lNtWSyv31gFgdJKcmucGf5AAjYZVS4qHvJ6mK/q6Pk2
	 hrc8UqClDplabI/pmHnXaWJHPBbOs5GEOe9REZqA6dDZNDrcclgqf7V1eEVY5Qg1DLdNk
	 z7qbCctJRb5u7Y8WTlkgl6VY9SVP7XYz7c8st+Wf4CSoqxhAuug4l8EjUiQEdY+3RrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C3/VARB9";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50717606A32E
	for <rcu@vger.kernel.org>; Tue,  3 Nov 2026 08:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50717606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C3/VARB9
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15dd124bbe7so5515291c88.1
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 00:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793696240; x=1794301040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Er/6bqz2N7+83QaIQ6D94RNvY6ZoeYk2XRlSx4xqVLM=;
        b=C3/VARB9Ki3INhlpjHk6uw34w0eGjBtr09D2pcJRau33CqrUBKiWngGSjA+cADcyCU
         /g8gav+ogPg2gM2vm97bmSe4uN77DKvTC0++azS/JtNfZb+vtpWfj0h/t+IdQpZPISzr
         NneQuIO31ZBa+SLp4ZgJvw0C5xtqOPLQ54p4Ou72UBGbwCrYQvp3R/4tOL2rJ2zv8nbM
         IZKHxPw06svFbE8O/kXyNZ6LykNqU2tTGXtCSfmLFgis2lO2lczOoFf4/44wMV1Feq+M
         1fdaeGPTHxI+HWPS1QPadsE4If1L+Ij+cF0apDlUreUjUZuST4N33nOf2F/d6D2/4udQ
         69fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696240; x=1794301040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Er/6bqz2N7+83QaIQ6D94RNvY6ZoeYk2XRlSx4xqVLM=;
        b=U1xSXqN3SKs7JKcO+dw9UXtZDJ8+MdxtjvY46vzAwdmRYotYFwJHFonbYFgMo439KB
         BkDpJ6b8HDOZNl+F3FsLhyDqJHZLIROXl3D8UiWH6B7+t9w6jogmqLXXbb3wTRePc/Hz
         9CFpm1KR34J9t5ZjL5O6uvEqO9DC4yLFt2j2RuQEFgoqL1oh0IG5sZOryQnQJCZFyD0a
         zyyrezZ3ljjYqm8WFGtzDSg6naafQgNRXs7u50DwU+JGIbT7uY3CRW2SzOi/g1HuquHr
         gCCsayRtqygdULrM+x7SUBBIsue8sfR3Q/opyYXExe2CeBHo2zNaawQGAQFGJcF8a1um
         42nQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmobNKYWRKLyJH825sLKaRl1XL3LZ+LdIe+9L4QfAFYWAmfRDAL7uDVmZ0b0LVO+4FsD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hxKAIbJ4Cv55xp4eF0iOyEG4WQeWjTEGhfNjQEhd0MdNKGU/z
	kezCEc5KR8PETIRVsPj2xKqBVg/AUGv+OEiTsG2TgzqTI1OG0AoxpAFq
X-Gm-Gg: AYBFou2l1NqSJ8UvXOGIRuL/KSaDWANWYovUQ6bPCwriM7wEFQGT4CuQXCGaRJQzWLR
	EuO3nL0zzvndciqvqqvWIB91QjV1YI67aq89tUmwBbCZrL7oZmz6l9ub7FWSStHMG25FmspNl+1
	XuhzRvdkIHL2UtAFbloXP68Qo2QHb0M3uACtSGCiwFJ1AS2u3nprMROk8Zog8UPztYv+KhQDo4B
	6RqzMvsYuefPFlH5rubMnrCzkU5Wjc/AEyL4lixe2TKR7jgJAtjzWG57lLX6oE4HGyyNTUWM8uu
	htXMDeHnOGX2OS9PSx8m4d0tzojIoccEE89H1NVkPHr1cgWDFeAASHHTFA3CAHPURm2HOFSXJon
	m9BCNnxDGtDhUFa5PsPNYmoE+fiV/OScxFzRU5uM++m72aB1OQmuWn7FzB9EDXsZs2v4SyabD8i
	z07/itiAjCDqgY1vOPLlSe9RQykak7ZU30Yjip4x8j3JFFT2BOQaoByuX48uCf7e18seHdzdY2q
	+XCX9b88+fD8OW3AyhheLj7um9Tlq4UsgmDX6y05OO1gh80+e4G+rfXjF+AKoHWL9yMd3J7H69i
	gmyfb+Ts/F5HN6R9uQ/A
X-Received: by 2002:a05:7022:1113:b0:1ac:9da7:e86e with SMTP id a92af1059eb24-1ac9dc67128mr17230382c88.30.1793696240266;
        Tue, 03 Nov 2026 00:57:20 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm39704029c88.23.2026.11.03.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:57:19 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: wait for SRCU readers before splicing the namespace list
Date: Tue,  3 Nov 2026 03:57:13 -0500
Message-ID: <20261103085713.3479756-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103081418.GB4301@lst.de>
References: <20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com> <20261103081418.GB4301@lst.de>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 09:14:18AM +0100, Christoph Hellwig wrote:
> This feels like a design issue with list_splice_init_rcu or rather
> using list_splice_init_rcu with SRCU.  Do we need to encapsulate
> and verify this logic in a list_splice_init_srcu so that other
> potential users won't get it wrong again?

Makes sense. nvme is the only caller that pairs it with SRCU today; the
others (btrfs, apparmor, ima, smack) protect their lists with plain RCU.

I'll add list_splice_init_srcu(), which takes the srcu_struct to wait
on, as a separate patch next to list_splice_init_rcu(), and switch nvme
to it in v2.

Thanks,
Qiliang
