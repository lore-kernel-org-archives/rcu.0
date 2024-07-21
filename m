Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC817FD
	for <rcu@vger.kernel.org>; Sun, 21 Jul 2024 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721529596; cv=none; b=CZOY4WUyvg0rhHsP8SMi92My54MQXcxXPjIeAUHpkQi1xzXNswrtcjOWM72V9cuUnUSFjg9AzxUB5RabJhcCmOlklGRFwdVavorVEdGgaFAFFNWW6Uk6AKZ0G/PpAHEWI/TQ7xwgcZJagdKvdKM68TiCMcrCyygQlqu9pUvjUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721529596; c=relaxed/simple;
	bh=fh8z2AULcINUDvcFHWS/e7WktHIAQaXkIMEEqliuQXQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lbufdMMmiPtg2p0voAqNlzIjwCrJZfDxcCtNiiuiQ11eg6ZbXiRvB9V7RFSpaydR8cmqCIb/aZ2Df8NWYxfz7uPDETUOK4zH2ApEJ03vN/B99PBLtK4cgDhSjD6pKAHWdqljBUjkYKlo9HuHrp1KnjL1JfyY8RbcC1UbnfCvv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNEvd74m; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNEvd74m"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd643d7580so337645ad.1
        for <rcu@vger.kernel.org>; Sat, 20 Jul 2024 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721529594; x=1722134394; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKhYQTKZB+KGFwG7X607Dvbh44/YyIGRnOi+f/Ljx7c=;
        b=HNEvd74mxxgjkbyKDk6ULbHTVYTzl0hWwBGNi6IgTzpRUgi8KpNgH1+zOS09312XK6
         pbtUXoO06OK4DW7W8Fz2p462Qp32DaoQPQ3639y20Lf+BbdeX3PpldDc/Pm6opMFYS/H
         KMqko4By5RLdXoTkByNVFuNX3aZNtEnbfGcS6YYlsKmnKZEk1G6EfwRJfrYONzb2P9Ff
         Rzo9dnVbOg60hs56+3LimfDNHLSfC/icgiwi+aMRs2dZH3IaW4ozV1U5MSvPV/Y7wKGf
         KtukXhuFRZ3q7KBAHrnZeznm4I6Xx7vW+9KSUnT3OFDht2y059C5rN3o3/va+nnOj2/h
         GB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721529594; x=1722134394;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKhYQTKZB+KGFwG7X607Dvbh44/YyIGRnOi+f/Ljx7c=;
        b=KDJuxUCQukHUkrGnow//dxQxeLDDjZCZt9gk1mVcWrDDSOdCgYaJPCCCtcl7dkROTe
         +vQvgA22v5wT41tmnigDqhWIfVCjnmexuhu6g8W2Rl5I8CxY370nlORD9W6Bn6mjysQp
         N8p948e7kM+YV0u4fiGFNzsoZtnJ0nFxL49dYq5/WtzGsxwZ2tY+Jy8sdGntEcJy5nTS
         ALrHZHr5fk9L4s7F37SyX+NnY9dpzbL6e2qCQm8xKuGnVLP79SGVEe5FpjyPMt78gur6
         cIDcWe1ppbAcYlBAuv7hASWNiUg/QSGPFj2V2e0sLkEOW3RhRVchYwRbXFcZ2hJ5B/H4
         ntYg==
X-Forwarded-Encrypted: i=1; AJvYcCX6A+4xu8kvwsU6i1RSQk2fb8UAgw9+GXpfnDMn/Z4ZhpOeNP15uQk/esSfa7uMnAX2Ks+xgAev4X9lmsuFGpJbzWWy
X-Gm-Message-State: AOJu0YxVZD8ekmPGYD5dkdAzb09/k6E/KRewlzupOKbN1sSDLIoHyJMz
	+T5R2JClVnokT4drwYu5jyHlWcow6nbY/m9bHw78AuXAnppczseCDkvXMV+row==
X-Google-Smtp-Source: AGHT+IHKuuroDH+lIH+Y4aN8h5NmQDJjCinbxuGocRwWGYbok5fX/mvloo0y4GqthRw+d5nwlHRWKQ==
X-Received: by 2002:a17:903:2348:b0:1fb:b39:ce4c with SMTP id d9443c01a7336-1fd7961f3e3mr1796205ad.8.1721529593638;
        Sat, 20 Jul 2024 19:39:53 -0700 (PDT)
Received: from [2620:0:1008:15:d155:1bfe:11e4:98f4] ([2620:0:1008:15:d155:1bfe:11e4:98f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ac71sm29087575ad.22.2024.07.20.19.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 19:39:53 -0700 (PDT)
Date: Sat, 20 Jul 2024 19:39:52 -0700 (PDT)
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
Subject: Re: [PATCH RFC 0/6] mm, slub: handle pending kfree_rcu() in
 kmem_cache_destroy()
In-Reply-To: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
Message-ID: <607f42cd-868b-28d0-8e94-819323557c09@google.com>
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jul 2024, Vlastimil Babka wrote:

> First RFC, feel free to ignore for now if too busy with merge window.
> Also in git:
> https://git.kernel.org/vbabka/l/slab-kfree_rcu-destroy-v1r0
> 
> Based on slab/for-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-next
> 

Thanks Vlastimil, do you see value in testing of this series right now or 
should we wait for another series to be posted?

I'm happy to run this through testing on a few different architectures, 
but not sure if you have an update baking in the oven that would supersede 
it.
