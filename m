Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237611B87F3;
	Thu, 13 Mar 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894923; cv=none; b=bwx9fhNM8j33tp2IjudIpcsDHHBiBFxpoD66NwMy1auWDuhFQ6PMOYIXO0TPTk2hoE3H5tdHKzHXQyJuf1oXYSJk575UiZfRyry1pHf9e3ZerPrsTgHwA5zXKkEWnCD4JBRh1zAtmmvvdC7+XAEBpXagtch8JpvIkyqcsnl4mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894923; c=relaxed/simple;
	bh=sk3viEXMUzBKhjMARhyrnSsq8ee9mr7oY4Bbj4Myb2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmnC9/Py332a/vTwQSgTjbLn5MdAdlw1s3Fde4mqo/xYrTcle7adzew3RgHr8WeGjnhGUfU5l1J8/t2+rrDe3GuDEFnPI7sfJMABj798C12ExauPJKUnMCwqJDuMjsGo4FjzcX/4Gv9DE8NKdNktFr2JFuLk3OvprTAl3wdkHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLkxKxQz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLkxKxQz"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e64700a38cso2029226a12.1;
        Thu, 13 Mar 2025 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741894920; x=1742499720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xw0k7AfmA5dM2akjpY9ss9QdH7WTzWElWUqseo7H/+8=;
        b=JLkxKxQzQWA/+5rMQ8nE5k9bQRHve8NfYStG61MgIz3neFpj+ipqg+8YvD73ywSYDC
         lTlInD5xcD8VhUPP+J4ZMwIwbLUV0Bl7MOxB4BV92/NoHnqRmuVEo3eVBHqyTFc4uBGm
         CCWbbN4z+y29Db0lh3bE8dd9j2B0dEyD+h84jN2t+Rn6H7e18NfliFQ7tYuCrIzsYOEt
         +SyZW+qUvLUs22NJKCb8Vwg4LklkpZj89vrem10k0sfHk7+dpKyBhuBJFyygPyHx4QhE
         O6Yn3RSlCmcVdcI8WP1mPJkFdIye3RFImME3WxWZg3FL8uffVXATdCmLKfciI/fuI4jv
         CA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741894920; x=1742499720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw0k7AfmA5dM2akjpY9ss9QdH7WTzWElWUqseo7H/+8=;
        b=Q0HOhIpx3fC5GVIlIiEfdFaNuDV2BgkQNoEpCCKL3e8Cl2TC8tpG5qQjENCEZfRZbu
         ndJAg86JJDOmGQaxYViZ3kJxmGDS2rxYpYRUScElRinVVegso8W4yyAYI1omw7Usj18l
         g7U/XZODHwnPyB0/GXjJ964pTgqgFnhTH4KmN8JIToGX4RBd87d/gArgzX/9epkORheF
         /gHn5b3B+nIFxyb4NcDQa8Y3IbP3pYS2RAj/ZXJLpKLJiydiYYvN8WXnhuP2GOb5rEzg
         AuU4RG83h4p/npIhK6FBd7432nqCA8HCRFi26UJ2r1dvQdlW7pq2h5AMfOdPm5M+9Yb2
         UWOg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Kl5B8Pgg6ZiUlnA+N+tT3zhms6n8A0Vfoa24i0DTKdj6AQWySfSCjxWbiuEJVkbWHJqJNcdcpULj5Gu5KR8=@vger.kernel.org, AJvYcCV4yUynYlTuYt0UknGaEhAfBJ3sC9RNNmLcd9H12km2KNcFJ0QXAEfH0HRpVzKc1EmnYK6U/DTFY4gO42c=@vger.kernel.org, AJvYcCVIIA7AGWFDf6yRdyKHLp1SzxN6XRkFUGy6byzo4ZXdXhi+gBaTvPlIwcTKgz3s6xfIj9Je@vger.kernel.org
X-Gm-Message-State: AOJu0YxTmrBqAcMe1045PfAHhtEPc3zHaBOnCvjcgjX5qx8jvjl6deBe
	EAvopNQBOWkX4plzP72ZjzP2cNaMHQ6wEIovqVSlQtAW5ndrjwR8
X-Gm-Gg: ASbGncu/e/dFyGMuXzAIx7k6pXfaD8RUJHeb2H69R0Jy0APCwIULL0iV3Uy+hdkBtUp
	XOePukCuyLhV9Y3eGuE+EczA4QdzP9Dytrk7k0/WtXniAralFkctTkbuogR9XKPyv2o5QXuHhip
	fCnXUqW29imXvjVxVg84p1kYCGNOwLdFN23tgDUbuI7htGjIQiSCHAabVBnFZoNeSI77KqHXoeE
	yTlu9l3MIQ3UbGjLi1/UJNs5qKQNV5NwnHfYWnAmu8wVz+0K5F2e4pTUF3kKg2mXvKvBDz52JAG
	XkDk5qkkXQ91w6qajplw0N8hddwgR/g6mRlxPhPz41a4i/kUiAA+n0/Mgw==
X-Google-Smtp-Source: AGHT+IHoo+4LuebpiIpFT3Jntiex2MG3CbprM8A2djyFXiFTXF59toxYT1UlmAublw5zsW7Es8WXTw==
X-Received: by 2002:a17:907:970e:b0:ac2:7d72:c2ab with SMTP id a640c23a62f3a-ac32969f1e7mr72558266b.47.1741894920224;
        Thu, 13 Mar 2025 12:42:00 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa6499sm115665266b.183.2025.03.13.12.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 12:41:59 -0700 (PDT)
Message-ID: <90b040e1-6f22-49dc-a58d-6041c24f5b75@gmail.com>
Date: Thu, 13 Mar 2025 20:41:58 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: sync: rcu: Mark Guard methods as inline
To: I Hsin Cheng <richard120310@gmail.com>, rostedt@goodmis.org
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com,
 urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 jserv@ccns.ncku.edu.tw
References: <20250312101723.149135-1-richard120310@gmail.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250312101723.149135-1-richard120310@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.03.25 11:17 AM, I Hsin Cheng wrote:
> Currenyly the implementation of "Guard" methods are basically wrappers
> around rcu's function within kernel. Building the kernel with llvm
> 18.1.8 on x86_64 machine will generate the following symbols:
> 
> $ nm vmlinux | grep ' _R'.*Guard | rustfilt
> ffffffff817b6c90 T <kernel::sync::rcu::Guard>::new
> ffffffff817b6cb0 T <kernel::sync::rcu::Guard>::unlock
> ffffffff817b6cd0 T <kernel::sync::rcu::Guard as core::ops::drop::Drop>::drop
> ffffffff817b6c90 T <kernel::sync::rcu::Guard as core::default::Default>::default
> 
> These Rust symbols are basically wrappers around functions
> "rcu_read_lock" and "rcu_read_unlock". Marking them as inline can
> reduce the generation of these symbols, and saves the size of code
> generation for 100 bytes.
> 
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> add/remove: 0/8 grow/shrink: 0/0 up/down: 0/-100 (-100)
> Function                                     old     new   delta
> _RNvXs_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB4_5GuardNtNtCsdaXADs8PRFB_4core7default7Default7default       9       -      -9
> _RNvXs0_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB5_5GuardNtNtNtCsdaXADs8PRFB_4core3ops4drop4Drop4drop       9       -      -9
> _RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard6unlock       9       -      -9
> _RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard3new       9       -      -9
> __pfx__RNvXs_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB4_5GuardNtNtCsdaXADs8PRFB_4core7default7Default7default      16       -     -16
> __pfx__RNvXs0_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB5_5GuardNtNtNtCsdaXADs8PRFB_4core3ops4drop4Drop4drop      16       -     -16
> __pfx__RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard6unlock      16       -     -16
> __pfx__RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard3new      16       -     -16
> Total: Before=23385830, After=23385730, chg -0.00%
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

Cheers
Christian
