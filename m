Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017A17BED0;
	Sat, 15 Mar 2025 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742020196; cv=none; b=gutxSJAWtsVtmuqhibbae23cRZhlG60KZ9JMIea+sJCykn9H88MAly/mhfazfnAfpel38B+rHFX53BViUbFgIC3+3S114krhHJuoqWjZ0jhiLti9h1S4EaJrwsYcE4pC1OUNxnYTQiZ4ig35JVJuvKC3JMVn280MRtNe+xqLKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742020196; c=relaxed/simple;
	bh=2HPC4NQ90xLggdKKKcJPiPY/4SPFxfrjKCH1FgSkKGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOMqabryJEItQg0F79hmHyetG7oS0ZtIWCbeG3V9tiwFT542xEUiU4Oub7c2yJSifdihODAB410tzyc3udW788UC6nbirKXOKZy3PMlaN8JUyfoW1PQemnGtP7LzmzIVPuuOwu6/lbK/3+edGRG1Lc4Myz7UeKhlI5/HypGuxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUn/T8II; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUn/T8II"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30155bbbeaeso508088a91.2;
        Fri, 14 Mar 2025 23:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742020194; x=1742624994; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tmfpLD0wSy9YLuamDc1npCFGqgQISAxicSJiRUT7xoY=;
        b=DUn/T8II/5ujFAYXlG7DL9kx/Vbf9hKVIh14i68Z8BfNXrr8kwhzxg4FRxmOHgqVyV
         4SwhJ1P3ydpaORiADotnsVET2uO/SPNMDgsJypDYXQWI5HtqruZWMDoTc7teD+5tjy9M
         ij+DlxpqM+ChnljIL1GhArMQqCB8iqLDGcq6MYS7hV+EWGIjFcEv+MGPb20XsNIrTOO3
         UXmaxNxnGgAdLG5EvgE9VV3kRFErtxU+on1jW1p/u+3NXrR0qEZIlkyZG9GK7ljUDBkF
         0Pa+4di+ukEmyaBMTKlIYaj6yUSlPjzZSV0b4ACkgIyg+tLmETX0eMsme7SQYTf7JYSn
         GMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742020194; x=1742624994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmfpLD0wSy9YLuamDc1npCFGqgQISAxicSJiRUT7xoY=;
        b=UrlzTu/cDvszQ558NPTRMbDY9b0uWzMsdFuauXZkmG92tpPYHeyxDYIiajc9PIGMJH
         UmsgZxgELiBybn4MfGYikk8zhCYtJi86ArnJBlYefBgIYYzUlbiNEQ2S+ZnBHQElozoY
         GPH0PE7qNYscTDXx5rIuf8NB9yU09mUsWZ6ks6g2BbtfTfkhtyEnqiULpH5tFjtC5GB1
         vQrWEbiwhxr3NDrWRG48krA8SS2J0+YLPw10nDIbZbQwjjnVQl6uw3ZinBICx641Hoav
         DJVUqBc1nnsyrhrtETw/s74GDhsNjTB7pva0gvV3NCiubtzmlq0pl3igeKYMJlpzCtta
         cmBg==
X-Forwarded-Encrypted: i=1; AJvYcCUEL5YJkuAM0qX5QiCPf5QbhYWkXJC+G2CDF4QZ2mXnzKjbIFvdATH3hu+tRDRAM9Fmi3ERavXz0nWIHjU=@vger.kernel.org, AJvYcCVjph+UV09aK83BVNEL+chViZUb/BYINFV04DKJ3bXYnWUtiRts0xcKDTtk1iSDyCf7L0P1@vger.kernel.org, AJvYcCVzuCI4iGT9/2UYBcWrbV+CIMEPrQcr7rS/xyzT5SuDEWfpZjXjG5/gSmIknFB6JcdjbdHSx6fHe9b7qoRpFdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xs+mgYJmLStaTO4cIR+hamR7/xZVOOLLfXLqjAWP40GQZWah
	pzzl4W0LS5EOoD58sl4o6MGZO2thAHqPArJfG/tIbtEindNOTzBz
X-Gm-Gg: ASbGnctyAXi/jHORf6QZ06ig72zcxPmtK6L505xciYOgdJxq6Wd+XFfdTo1o+chOWEw
	gpBMgK2dVQx8NUyX5cNF0gI4cNkiNVKRNjJDLLMSSAt6OeFKUNUITsod8FRlkjCMZNaedtgmiaH
	8rb5baECY7cfy1+b72Vf9s1Eq0NLHYVsZAcBNbaMP+AcPhM/A+z1IkbzDNXvmbl14U2RydaoKVp
	/zxaYW4q3cB7z8x7wO8N6gMMw6Lg+UTapzdp5GHDmSChCCX6cwcJ/s89KH/PVaoZ3WhnPqwuWqI
	LnEjRCho/ba4v3XHEeT2W5I60vet4my25sFKJ3hHmkJD91VQUq/EFoTXpJJhfw==
X-Google-Smtp-Source: AGHT+IGEcLAhPjis5DBeTEtDbcfTF37HVEoGh0kLkHJ4BZpXiObeLfEaIXG7pBvmWdz4S7hygKD7Ug==
X-Received: by 2002:a05:6300:14d:b0:1f5:a577:dd1b with SMTP id adf61e73a8af0-1f5c1126db5mr7478656637.1.1742020193858;
        Fri, 14 Mar 2025 23:29:53 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:c5e6:ccb8:a191:9f7d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b2bfasm3955892b3a.177.2025.03.14.23.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 23:29:53 -0700 (PDT)
Date: Sat, 15 Mar 2025 14:29:47 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rostedt@goodmis.org,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com,
	urezki@gmail.com, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] rust: sync: rcu: Mark Guard methods as inline
Message-ID: <Z9UeWyrcK1t27SQV@vaxr-BM6660-BM6360>
References: <20250312101723.149135-1-richard120310@gmail.com>
 <20250313043006.GA1396688@joelnvbox>
 <CANiq72m3pDny0fUkg4XAFsuA72ku0BKcoj5+zKza=o6Ek_QASQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m3pDny0fUkg4XAFsuA72ku0BKcoj5+zKza=o6Ek_QASQ@mail.gmail.com>

On Fri, Mar 14, 2025 at 03:43:23PM +0100, Miguel Ojeda wrote:
> On Thu, Mar 13, 2025 at 5:30 AM Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >
> > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> >
> > If no objections, I can queue it for 6.16 but let me know if Rust maintainers
> > prefer to take it.
> 
> Thanks! That would be great -- FWIW:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> By the way, should `read_lock()` be marked too? It just calls another
> (now `#[inline]` one).
> 
> Cheers,
> Miguel

Hi all,

Thanks for your kindly review and comments!

> By the way, should `read_lock()` be marked too? It just calls another
> (now `#[inline]` one).

I'll do it and fix the typo mentioned by Charalampos. I'll send v2 to
you ASAP. Thanks !

Best regards,
I Hsin Cheng
