Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85241383C97
	for <rcu@vger.kernel.org>; Fri,  8 May 2026 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260023; cv=none; b=JlTBUDJCEi43PMfnm/2oFpKkCc2MSL3fE3XcdenerCsgGJYyen7SeMnoGbk0K03JZBb+F6iuUcYlBQZUR3b32k7dx5ac1GxuZJwSg41EX3nIUdNKxmKDYqJNWeMIMYb1qLnsve++EmrPEEbCB7V+/MHu1E+07wEH8RFhGMvEbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260023; c=relaxed/simple;
	bh=EgNZfIkmaGVc8ylvTe4XrBRxY84EKDdexRzWBAy74II=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogjk4JAC0G1lhehn5aiLQoQWkIlFlpYlLj8C8C7YDXHvXm9bqsLGDTuowm2955aaOjI+EXG0kuRuI9SzsyCgcvOxwxkNVUwXGRpTqjZQswjQWTJzL9f4aElmChU7K/2gA+zZllzaD3ud3uOWepJpFeep+h/sVwv7Wbso6xRHEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltHTBtWN; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltHTBtWN"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3938d17d6c5so18554081fa.1
        for <rcu@vger.kernel.org>; Fri, 08 May 2026 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778260021; x=1778864821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HXkCnsk51anVcA2hyeLzrqmlA25SdT/u1evR6808mvA=;
        b=ltHTBtWN0sfjzwBgRzdjQC0yLub9awMxZik2orvRjYUS7BgdFzMm/CnnBiuu0/1j8R
         LGUl8WO0AolOldZXdW41LBZOSE58IP3pKCKBo8Qwhsup55YudE467MB1L0F3FJh3MxVr
         pIrg09f/sMeg3+FmGpsjSEUMR7QK4U6y/BoK4UszV89zC8tEOC4S8SUQXcszlo7CCwAI
         Uh6FtWm5NBww1TpciKPl2JBqShtw1rOr+es042s1C8oZb01UoQpnpE3dbxm9INnE3vqs
         kD8FekTBfhALNsO8RFLTP6rS6B4pQysqIA+ELDt1wuneYBRwXcDZXhspelEy494Tubo/
         s6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778260021; x=1778864821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXkCnsk51anVcA2hyeLzrqmlA25SdT/u1evR6808mvA=;
        b=M+D7mbXDscYBo4ePrBISO1Xt97IvBgiegR7S+9BCFCs+EWza/1iPIic48q5wEk3wBG
         qQ7gceSK6AfQiPDT+AwHht1ZRIXSl/2ZKF4O8J/fixZJb6RXE32FDN6Le+Prw6wHeF6F
         YK6SfB5kJMd2mSJopDX4PJ80hN7RjuoPX/R6XPSu1ggMxOa/0j4y8N35Ti6dvu/68Wh+
         BFMeYBhJKHtrdv+vBu0NutlU0v/AsqMaLHtuJRHh7eNtTAarJO47h7V4lUMb3YnaVhpM
         9O4He8bTnjZDoXlcKAlgq5zsyBGvOc7lXgyYscESCrhJOG7X2tlPRUtH9KVNDlk38u6X
         ecxQ==
X-Gm-Message-State: AOJu0Yw0VqlKN4Q1tN1UvhRMqt5BfbdT1T+rwIFLeVYU0VJkn6mBGvTI
	ExFjS5kWUBLCksgTVtmxZ7XcaLd63UE1Se63QARUMK+vjSqL868uaAbG
X-Gm-Gg: Acq92OEWx1GFqHIHuBm/7sy9dmrdOEXK1qrG4tUnZ3217n3PFkC2tMa39h+OD6TLEWW
	KEtPjIstxG3siIISvX0IC/lXUb7urS9nC7EC9A00THc/gnqE1APetVFn/ny5qd3uJc+mBF7nXO+
	EtVdfA3zT3grtD81e+KzH1bvWZqJx9sOJ6lp7GxiivJR6YfNaRfFEv/A3u70K5BL5jebsNhIpLe
	YU0GeoBKhpwe1JgJRIcLbMo8DfFY5Ozrz6vvcmEux2zNiiBfKiK+iP1Q8eAYYvVjY027SWXBjkH
	OiVsOWtIbLQAnpYuUAFWQOBmHkav+LjMhXVJ4pE8qJ8W20F/AvvaNkHLWiXTTqKeLHqw4Nag9tO
	KTrvD/8tAEIXLIPWKhYePSrTTD4yj2Ck2/tXYRqm3ziVpO+pj5ZCk51SqYck1kVZJ
X-Received: by 2002:a2e:8a87:0:b0:38e:84e3:3476 with SMTP id 38308e7fff4ca-393c42108abmr48877861fa.25.1778260020409;
        Fri, 08 May 2026 10:07:00 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f3ae30sm6469111fa.14.2026.05.08.10.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:06:59 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 8 May 2026 19:06:58 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/7] Miscellaneous RCU changes for v7.2
Message-ID: <af4YMkfQYtgZNuHl@milan>
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>

On Thu, May 07, 2026 at 10:09:42AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series contains miscellaneous RCU updates for v7.2:
> 
> 1.	Don't queue workqueue handlers to never-online CPUs.
> 
> 2.	Fix kerneldoc header comment typo in srcu_down_read_fast().
> 
> 3.	Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace().
> 
> 4.	Mark rcu_read_lock_tasks_trace() and friend BPF-only.
> 
> 5.	Simplify rcu_do_batch() by applying clamp().
> 
> 6.	Simplify param_set_next_fqs_jiffies() by applying clamp_val().
> 
> 7.	Document rcu_access_pointer() feeding into cmpxchg().
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/include/linux/rcupdate.h |   12 +++++++-----
>  b/include/linux/srcu.h     |    2 +-
>  b/kernel/rcu/srcutree.c    |   12 ++++++------
>  b/kernel/rcu/tree.c        |    2 +-
>  b/scripts/checkpatch.pl    |    2 --
>  kernel/rcu/tree.c          |    2 +-
>  scripts/checkpatch.pl      |    3 +++
>  7 files changed, 19 insertions(+), 16 deletions(-)
> 
Will you resend Paul? Combining 3 and 4?

Or i can take it and combine 3 and 4 on my own.

--
Uladzislau Rezki
