Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE943143C5D
	for <rcu@vger.kernel.org>; Tue,  4 Feb 2025 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738662644; cv=none; b=sTkLwPELr4ysP62cl38nW6zc4voIUEHad44Ju/f25k+z8TYTXkz2ligSPUKxv2K5R83iYWyJDsuW39lUSOrAQg9SS3sul9icsEZhJ6pGvjIsot1WSa7JTouwoM579wSuzNXzvi2uFdCAWy8u2dC+QE6uSQre8AB19PlgIW739FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738662644; c=relaxed/simple;
	bh=FgkbsOhFN3IK5fL4WNJOhy9meWGErSW/VkVTkZRLrdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsu23PMPHeaTL/Zr/Hhwaf5eI95a5reUviF6nlQSZ3BhEyEgW8nDCEID+VeyIDMf8Vn5w7bkeZAz6jRSzOnBDTORewEJvMukaGilWzEDkLRdEb7+y408m93410WKJ1QKZIa8jtJeCF573gzqqGJWpQlSGkfwdDZ1o6qLdeNvD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNvwwLV+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNvwwLV+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b662090so104208795ad.1
        for <rcu@vger.kernel.org>; Tue, 04 Feb 2025 01:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738662641; x=1739267441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lrEW3b3gEfwiOeaiNfqHI323muuemunSP0vlaeBukjg=;
        b=HNvwwLV+Pr7FWAflAYdxLKBZ9BPsxX9Ytquq4Zdv0C6jprqsPof1sq1lq8sRC2RA1V
         RBlovDd2p5CZYxnFibtocRBbnatp0KI0CK3zzeAlC2LqPLuaBNE4J5WJ6q2Qrbb0eTn2
         YYDcJZg4VVljRm+AiDier1KtrLxUDWQ6irC5E9qAaxaC47byLoXaMzt5V+bDZFSs4x3g
         zeFCphmXri2kc5ss1nona8nVfG+AuBW4Iv1fPL06JYVwjvQ1AgaWwSojpLfJnSP4H3St
         HwBg1efPO1P98u5Sx1VPtacQTUTgniLDxUKfd7wTamkN6x2m7QAm5UeC8W4e1qA9tdq3
         ImVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738662641; x=1739267441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrEW3b3gEfwiOeaiNfqHI323muuemunSP0vlaeBukjg=;
        b=VypW0gUja1PGg8YwZm9Qk6zJ6a9pMi9UybRmrOmSxYTVf8Ffyh54XivmfsJYKIBzR8
         VivmgXvrR9BCSQtOl+CoaOP2SAvQD8VHlvEtFhXDm+wQVUC/Wk7PMAOQF8ibVaaBZBNm
         4uZ6QO0oDyH/r7QT4KHKtAmUH0QB0+TAOyO+ls8HGk26NfZoA6XQ2CV6fG9DsIXDIC6p
         9zqwCHZqsweAOz31ykTX+xsFlCIyr9RSqCIPpvJpptLZjsQyyW2G4vRauohz95URJj0s
         df2sgPhLI0JBzewnMjAhPPOt0bIsoUpNz4R0kEbd29qbn/Yvp6Pl80N/Vx7LWlppm0py
         8Efw==
X-Forwarded-Encrypted: i=1; AJvYcCXER2t2+4rnRgGFjLDADYYHVEyiQ+8Y5XucwJIBrTrng3XOO9sTOAPHaCN3eZ5+fzS6PPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOE4IRoikLMuHCtg4/CpSEaWowKVwX4bmjIbw/5nikAqRiSNT
	HADuLEWBXwalLs1uW5ANcVMRLoZCzYnDK//Jk/zCsGucJwRKQ4ih
X-Gm-Gg: ASbGncvuE0ZSJcD+DayHT/fZw32qUcWWE5q6MVd5VTig6yX6n0gHNMLb0Pphav+hbEX
	nsQgrzH+MrbSqCxteQ7YJrbpNjt/yqwcvtDYff1zRgASgU7KuJS/Q6kwj3E89R1TrK2c2FP/ic3
	20FnvJ3eYQAuwNkhO63bd64grJLxJ2453WtTZxW/lKsDErZQlQRNV1vg3CbD5E1kHfbY2idDC/5
	cremwrUG5HBADibUA6wrEz2QGNc+pY1TbLFVcd9d92gi0T2R0iV4gKDR/0r/pD5v9e1Aj0vDmMs
	kifSueRjs2HfYlKAhqLP/4FUjhZvbBNr+o1j90U=
X-Google-Smtp-Source: AGHT+IH9kHdZSRV6hVa9kY7K6B9Y8fj3hyVyLtJ/ValbzpNXv9E3lBzuWNhpDDZAyNT0lK7zunRklw==
X-Received: by 2002:a17:902:ec92:b0:21d:cd0c:a1b8 with SMTP id d9443c01a7336-21dd7c3cf57mr421419275ad.1.1738662640851;
        Tue, 04 Feb 2025 01:50:40 -0800 (PST)
Received: from MacBook-Air-5.local ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331f8easm90307005ad.218.2025.02.04.01.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 01:50:40 -0800 (PST)
Date: Tue, 4 Feb 2025 18:50:30 +0900
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
Subject: Re: [PATCH 1/4] slab, rcu: move TINY_RCU variant of kvfree_rcu() to
 SLAB
Message-ID: <Z6Hi5gdaVd4_Ctyf@MacBook-Air-5.local>
References: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
 <20250203-slub-tiny-kfree_rcu-v1-1-d4428bf9a8a1@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-slub-tiny-kfree_rcu-v1-1-d4428bf9a8a1@suse.cz>

On Mon, Feb 03, 2025 at 10:28:47AM +0100, Vlastimil Babka wrote:
> Following the move of TREE_RCU implementation, let's move also the
> TINY_RCU one for consistency and subsequent refactoring.
> 
> For simplicity, remove the separate inline __kvfree_call_rcu() as
> TINY_RCU is not meant for high-performance hardware anyway.
> 
> Declare kvfree_call_rcu() in rcupdate.h to avoid header dependency
> issues.
> 
> Also move the kvfree_rcu_barrier() declaration to slab.h
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

-- 
Harry
