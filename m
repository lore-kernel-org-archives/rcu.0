Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFB1A275
	for <rcu@vger.kernel.org>; Mon, 19 Jan 2026 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768798414; cv=none; b=BP7lJDMoCnlFDw4fdWPixg9KCDlv1ICEJSnDnsDkBkZPjKmC1+nK9rUpgsiG0FwrLHhxHrlvtfp4jv8FUJt6ZR7QWiQDm2lE8zbKdt/66fdBvhaK30peDMq/qpzM9npTN9swlYAX7K2U1lkywcZLTs8F9CwDflMcm5jVZd3yhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768798414; c=relaxed/simple;
	bh=T6/HV4gbuRJQ+AvQZ7+CT1q5Q6si5/mylzeJ4QBCmrU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NRlxwUfAX7H1c0Y/+9FboR4xS3TK63fKZINLPG5+cYWv/y1X8jhx56dpbR1JbKUjZ2ISQbzqvBhSRV0GcEbzDqEs9tObPLY66QMpNR3fXagxhUqpl9DEbOOKVq1WUjdUTd5qG9wev47wWNPfkDVUX1BFo7dweA0WnssKgVDgRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DotfiNgf; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DotfiNgf"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c1e4a9033abso2099003a12.3
        for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 20:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768798412; x=1769403212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pkT2ZClyGsf13AYp6L2+G5W9522CAMmrzOXbdAupBY=;
        b=DotfiNgfb3ewMJ2F0LJGfEr73/SlPKBHBuL4Z9eOj88uY6/VTrrM3PjxaIC0QJpSP5
         b4KGnXB2VPZ072XCWy9CprhTWTxtSDU7rTMVyDapIk7Uwz4niad6455+p4JCi/kg0pUV
         Uio274h4RfmEXDRCvy1lyRNWoNN/+ROZgwd+H1nej3RX9iAuOoitka4E/qam0qmcA5q2
         chbSnYJ19obibK7YgEqAKsyaVLBzI6r5ppv1s+zv5sTn1+WBZ8Rg6OILb6z5D8dk1UCZ
         3Xd1jZFJMqkv2BPnjh9tK4R8YA8Szys72LTP2W/NLgFqNtFgoLC5TdeoKPBW/PcRyuTq
         UdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768798412; x=1769403212;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pkT2ZClyGsf13AYp6L2+G5W9522CAMmrzOXbdAupBY=;
        b=Ab3u+xFXNgYQL7U2umU9hHKMgh6XdMsSuy6vBz2DbQeX80+rGAH+jN9SEaimm5sTV6
         eCXisH/1NA547a1YCXQMKpgaQnTPjTABG2PI8gg/brkEGAywE2E/T7MfhhuOZW4jArJn
         6G3pf13XsEVdR470B7z1TwZQXlQnfM1CseAGQnUUhqifdu3OI6wOy7MOwZDDa8YO2zPj
         SfHaAnfR19nF913MBEHcYvA0TkmM6CqHzOUaib5cF0gvaAHcDYBZyEiPIKw+DyaslDq1
         Yq0U9XKM9pptNlSTL7tqhIgVEuPFvX7xPYqj0TwpuAjwDbR/AUdvp+vEF9/c2Yr45QOu
         /wVw==
X-Forwarded-Encrypted: i=1; AJvYcCWvvqWT81oxhvktG/xtT2QmExmSM4kFKFmKWPQixRFtGcyx4lr/NL3126qiSe7Vtwsmy7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJGNJGHlp3fooxR10Bqvc7Niy4lZ9sb+ZI05MQMVQdfHGV5jc
	qN56n526uJvA6NCG9oowdZQ81YRNMjC407Hd50IoMDYt69EXftZS978A
X-Gm-Gg: AY/fxX6nUL8WkXdJgRAqggpqoNhhCerKzz2Iy5DNRj8krjEZruk6BS3BhfOCQY4lIx1
	sNB8oQpIUqmjJ3djlUBDjAh8KAUKg1yGxmKTU98bKzrkuc0tDCusO9smt0a9vl8IaVdE9XbpnhZ
	UN5f5jz4iu/u8S4L57/d6CoPOCupX0x56mSv3rZDY58KUaUbMItoifoUj47nrzKeb4QJnAtXpsM
	58o6Hi1nol1y36xgL5Pog5fmwaf7Z/jmi4/4wZuawUCfSCXv0OZa9GRPQcs2FiCiuHuyRDMpaUK
	JAXucaT8KngdAoLjMXoH4luLcYM/EWSq1xFue9AGNg6U2mKPyqCHf9fTTD2YpkZqpwaOIycWTod
	tPYJxsM0/RJ5vkd8nihkkv2XcalfL9swBOEn9q1DwloEmLV1P475mawDQFjnwJK2AnkcKuCDHBq
	tYaDex3MlCEWyXpPcg4DNoYtXeEb52AuaIO77co+Vrb4s0RpDPOCDp27xBk2jZKovpesg=
X-Received: by 2002:a05:6a21:394c:b0:366:14b0:1a3f with SMTP id adf61e73a8af0-38dfe80caacmr9952987637.77.1768792189046;
        Sun, 18 Jan 2026 19:09:49 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf232f00sm7739170a12.2.2026.01.18.19.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:09:48 -0800 (PST)
Date: Mon, 19 Jan 2026 12:09:34 +0900 (JST)
Message-Id: <20260119.120934.33535744184163382.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, will@kernel.org,
 peterz@infradead.org, mark.rutland@arm.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, urezki@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, fujita.tomonori@gmail.com
Subject: Re: [PATCH 4/5] rust: sync: atomic: Add Atomic<*mut T> support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20260117122243.24404-5-boqun.feng@gmail.com>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
	<20260117122243.24404-5-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 20:22:42 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> Atomic pointer support is an important piece of synchronization
> algorithm, e.g. RCU, hence provide the support for that.
> 
> Note that instead of relying on atomic_long or the implementation of
> `Atomic<usize>`, a new set of helpers (atomic_ptr_*) is introduced for
> atomic pointer specifically, this is because ptr2int casting would
> lose the provenance of a pointer and even though in theory there are a
> few tricks the provenance can be restored, it'll still be a simpler
> implementation if C could provide atomic pointers directly. The side
> effects of this approach are: we don't have the arithmetic and logical
> operations for pointers yet and the current implementation only works
> on ARCH_SUPPORTS_ATOMIC_RMW architectures, but these are implementation
> issues and can be added later.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/helpers/atomic_ext.c            |  3 +++
>  rust/kernel/sync/atomic.rs           | 12 +++++++++++-
>  rust/kernel/sync/atomic/internal.rs  | 21 +++++++++++++++------
>  rust/kernel/sync/atomic/predefine.rs | 23 +++++++++++++++++++++++
>  4 files changed, 52 insertions(+), 7 deletions(-)

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
