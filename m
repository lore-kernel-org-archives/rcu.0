Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73533804
	for <rcu@vger.kernel.org>; Sun, 21 Jul 2024 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721529415; cv=none; b=lZ/8o+3J17A+rlfwKAtOKS9cFaEltOnl+Ib/EGPzjD0QET1+Lw+6Q0IPcHXlhmItit5aqg9yRqqWiCNKLm3iYZmlJc2uc/LuwIfoy1/ilWRK0pVw3sxw+7tv4l5TbjuljOGfm/hSpYhNNZrMDOltoT3/3A96j9TOsGRordWOT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721529415; c=relaxed/simple;
	bh=Na4s6px+nYKJhZQCRLM1jeQhAQ5XqonBmmGdRkHLp+8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EPcRAgp9wSJW4McLEjSNIjy0Qi86Ywrz1xQuYcAf4P4TRjXdp+lfNfxPYBzFCFJCuMzMzsnf0Wx5Bw+KDLqYz/5lV/I+MkMlxFyPb4rki5hxpLseWqTDuB9zdF0YcK2pqh1CLzevTSTo/BWDDXrKtYQ1hzvuKUBgMEZATXt7waw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2QoyvwA; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2QoyvwA"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-38b3543541dso366665ab.0
        for <rcu@vger.kernel.org>; Sat, 20 Jul 2024 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721529413; x=1722134213; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=12ync0Lb4d2F1abrlWeB7dvBZQvc4tt3x/Yoqnt4ykM=;
        b=z2QoyvwA4cCykQAMpPEgvxMSwu4500vmxzrbnISehGlQSnbM1DeVuRFbcPPgIkVSCG
         qFjYnBeNtJybBszJKGdkqny8KPKpeCFcLmkn/9eXSRDBqdM1LjpTX8exSz+buaBil/oN
         e2zJPWFUR36S47r/f11j27KuXSA8cUR3NrYSVtxlRoc4egzZrIilkQflys/casIfQxBk
         iJgk3ToQmhUnexUx3WXobMpOhg+BIksfY8kdkOgKQUR/S88ZC4daIuXmhRrjSf5rFrWC
         Q2MmhfYdwaK09/E4T+fQ5QaBsW5eMjQVOgNMoOKI14p7LZALhSAFCJA+cpzlfvXNn/1e
         kjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721529413; x=1722134213;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12ync0Lb4d2F1abrlWeB7dvBZQvc4tt3x/Yoqnt4ykM=;
        b=d1QE2gbSzzFfZIR/YaS2oxy3SisHcV2Iuz6V9RbUzSlh9V1I5chgTvXfN7wch2WOXz
         LqdtAQnY5elRt23hlhbdQGDMu0lFljMQIEPPUGAFd7/f1s6EgmXwLtUWfq/tLOLJ1Trh
         fwfraklRhXiDpPZ/ToCos2OyfjrpRCL5vY1x6ndWH/PBEVb4kov8WJam9cg/tu0F7iWC
         0fHzMfWSzYUKABto8rWUkZcPejJW9xBibStoaTxAZ+Fi/NTvuw3CwaCsmXTBMcRBE8yn
         h9QcYPe9W1D6r3rEGSNgVh5+HxXrL5zYy7bA/RGHl+xT/g3JYpOCzTiVw438XqUuzxUo
         q7VA==
X-Forwarded-Encrypted: i=1; AJvYcCXZeWtjy37gZ/GrEJmNZGzvH/B96vSFqWEwb6M8E5DdtEiYmJ3bfhks25uEx/NleXH0tIKd2dOfxTislW81LKXiryGH
X-Gm-Message-State: AOJu0Yx7BfwrnZ2dVZnK/IK9mfr63uRT2YsOULdWUR9UBqNLnJz7veLd
	rE53+vmphkSgWEgRzM65jJHao1NmBZMOFtFmmj+hiwXyiBhV9G5eN1MkyS1pCA==
X-Google-Smtp-Source: AGHT+IHaWyfLHZqQJJ7xwEP3Xb152xsS5cesG8Zsw5YEWHax6vO5+BwIjS72+uA9u8CaVnm9Uou72Q==
X-Received: by 2002:a05:6e02:1a4b:b0:397:98d7:5175 with SMTP id e9e14a558f8ab-3993470751amr2299655ab.12.1721529413262;
        Sat, 20 Jul 2024 19:36:53 -0700 (PDT)
Received: from [2620:0:1008:15:d155:1bfe:11e4:98f4] ([2620:0:1008:15:d155:1bfe:11e4:98f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1370c6a0sm1290154b3a.185.2024.07.20.19.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 19:36:52 -0700 (PDT)
Date: Sat, 20 Jul 2024 19:36:51 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: "Paul E. McKenney" <paulmck@kernel.org>, 
    Joel Fernandes <joel@joelfernandes.org>, 
    Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
    Christoph Lameter <cl@linux.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
    Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] mm, slab: make caches with refcount of 0
 unmergeable
In-Reply-To: <20240715-b4-slab-kfree_rcu-destroy-v1-1-46b2984c2205@suse.cz>
Message-ID: <0862b091-d5bd-1492-b12f-19657604eb54@google.com>
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz> <20240715-b4-slab-kfree_rcu-destroy-v1-1-46b2984c2205@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jul 2024, Vlastimil Babka wrote:

> Slab caches with refcount 0 are in the process of being destroyed so
> it's undesirable for new caches to attempt merging with them. A
> synchronous destruction happens under slab_mutex thus excluding
> concurrent cache creation and merging. Full destruction of
> SLAB_TYPESAFE_BY_RCU caches might be delayed, but the cache is still
> taken off the slab_caches list immediately, thus unreachable by cache
> creation.
> 
> However a cache where __kmem_cache_shutdown() fails because it contains
> objects that were not freed (due to a bug in the cache user) will be
> left on the slab_caches list and might be considered for merging.
> Also the following patches will introduce a possibility of a cache with
> refcount 0 being temporarily reachable on the slab_list even in case of
> no bugs, due to kfree_rcu() in flight.
> 
> For these reasons, prevent merging with caches that have zero refcount.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>
