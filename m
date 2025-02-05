Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33142185A8
	for <rcu@vger.kernel.org>; Wed,  5 Feb 2025 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746829; cv=none; b=raZZLbI7eSo1wOcUipwGotGvXzO1wjCc2U5FgZXhnhlipf4uZtz2TBt053o08qkqaH9QFlw61qL6dn3X7yIFngx7ZwK/etQlBKJWsR99HLyAoy0+8f/aF0OlJVEmEbDzkly5YCnv7Frk26hk9kwIno+nQ0KWa2VyIeIzP6G4cnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746829; c=relaxed/simple;
	bh=BWc1Rdmpvm4dfhgWx8uNVH3MJB5xnB0MDNRzcGhlLow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b55twDhqTCMpg7lefyODi42BnnXjwebu9lif0bi6xtNaBTZdAzt4EuheZ49wnZb6dQH46Q3LlagEWBpLuzJCz8Kk4DT9HiT5Dc2CRbdKz3Ig9z/QlhYF2wX8/ePTp2bqdzXcnxN9a7BPJUz9+9TBkc3FzkaaraR8ZaRIvxZav38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSpvgFv0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSpvgFv0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21ddab8800bso92994455ad.3
        for <rcu@vger.kernel.org>; Wed, 05 Feb 2025 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738746827; x=1739351627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gF353iZ2yw5vN9So1t8QaGUqLVsGg8dL36FMAbegCU=;
        b=RSpvgFv0t4u5SF7XBxJu0AJxAkCZGjP1EDIbyTsHuiiAlfukoYosTsUg1PIlZOXoxl
         pE5sVv8hCzGG4IHLEeMxDi0gaLLk8SbVkLBXn8ozWD6INpxCXbvkDujMPOlz4y7bJDAo
         w5tnwkA1gJB4Ay62OXCM0eV5M32sG35BGN4vLizUeCxgZjXY+sOOGrzgqhpuD+noPhV0
         jtze+5kxuiaeQIEKJD7hrltqUgzITubjEElWKPd0qy3SnZem3pL16KzZ5XDAjpYkXukV
         ZAFSqBTxndYWAlqkr3sEV11dH8h6gKbodWXa1744X23oX7U6zkH3Gdf3bx4TuW6r9GCv
         Aq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738746827; x=1739351627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gF353iZ2yw5vN9So1t8QaGUqLVsGg8dL36FMAbegCU=;
        b=nzvJL9sR0swPnFx3OfZ5n3QOxe2h0G1/Wi9ztFRLxio5rsRSVWUmXdEhustS9snDeF
         w8wOUejE11Kvyyc7LUq9ZPBivZoqtcSRJFbGggPBm4ZlkEO5X+mZ3vj1njFeBQ1ofsWh
         dgNfsrUGnB36VB0DRIzPLatATvXNEzeKkhxPmhYOmoOXSX4g5gV1qsWzWH/II88yBkye
         wneUwps4gqL38Dygy4/OnfrhZ52iD/yN+/5AS2s22GNf/sZUrDEw+gSp6cCO4O1ReHfn
         Tt9wwKx1V6Djc42/JURXzZMpAIgbUrxgMX8rHGZsQ5+IUcBthRTR4g7W//kORcYqXLJe
         LRIw==
X-Forwarded-Encrypted: i=1; AJvYcCX5qA5n7ymti76aEed5Y5xCuKSyNvV21BRhkjIHEh4RS93lp4szWRmY8ZEl8I1J3/Kf+js=@vger.kernel.org
X-Gm-Message-State: AOJu0YznbvZ+TOcQdFcwlU23FHZvig4+qOlyIOEmv4tt3buzwImskpn5
	BP4tEkHfqaW+jcjsVisAH/nnUFZmdvU0STQXv5+wYbM22TSQakfL
X-Gm-Gg: ASbGncslIlPQcXRZOn6SvELTTnoDzFT2/1OlNZIYv6Skedsx6rwQZgJsZbgY6zB7/fZ
	MA+WPBva/israQNPxvZnt4wJJ9q0Rmj9d4M7Z0p9XfyADDeKbpcqUMKBBOu9qHFzKPcdAummS6r
	Kqua6dIdoGWGOkLL/fFcd9WCPnlC/X26BkKpaXZOpPj7ralg7x5R4Kg+2DG5a1df6D7NJlkZaZD
	1kJYRvVnxcm8Uq4iiHCg6D1DSJ7pCw/KkEmAMb4GzktYOHpVsvg3jTSZM2Ji06CLy7q3A35dw09
	mvQVN3vjgqCPTwqUzXTPM08neRzHaiJ9vFAWMiA=
X-Google-Smtp-Source: AGHT+IFKFULiDyzRU53IFAsL1WTmjkLM37iRTzF1gfrP3bgNfPqfVb15MXkAsPlTMkLU3IiqzW3Wxg==
X-Received: by 2002:a17:902:c941:b0:21f:1096:7ce with SMTP id d9443c01a7336-21f17e4900bmr34403485ad.17.1738746826630;
        Wed, 05 Feb 2025 01:13:46 -0800 (PST)
Received: from MacBook-Air-5.local ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1d77ff9sm1041407a91.13.2025.02.05.01.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 01:13:45 -0800 (PST)
Date: Wed, 5 Feb 2025 18:13:37 +0900
From: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/4] rcu, slab: use a regular callback function for
 kvfree_rcu
Message-ID: <Z6MrwUgsgX-LK4eY@MacBook-Air-5.local>
References: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
 <20250203-slub-tiny-kfree_rcu-v1-3-d4428bf9a8a1@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-slub-tiny-kfree_rcu-v1-3-d4428bf9a8a1@suse.cz>

On Mon, Feb 03, 2025 at 10:28:49AM +0100, Vlastimil Babka wrote:
> RCU has been special-casing callback function pointers that are integers
> lower than 4096 as offsets of rcu_head for kvfree() instead. The tree
> RCU implementation no longer does that as the batched kvfree_rcu() is
> not a simple call_rcu(). The tiny RCU still does, and the plan is also
> to make tree RCU use call_rcu() for SLUB_TINY configurations.
> 
> Instead of teaching tree RCU again to special case the offsets, let's
> remove the special casing completely. Since there's no SLOB anymore, it
> is possible to create a callback function that can take a pointer to a
> middle of slab object with unknown offset and determine the object's
> pointer before freeing it, so implement that as kvfree_rcu_cb().
> 
> Large kmalloc and vmalloc allocations are handled simply by aligning
> down to page size. For that we retain the requirement that the offset is
> smaller than 4096. But we can remove __is_kvfree_rcu_offset() completely
> and instead just opencode the condition in the BUILD_BUG_ON() check.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

-- 
Harry
