Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A51419A9
	for <rcu@vger.kernel.org>; Mon,  5 Jan 2026 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626812; cv=none; b=OfKNFNTYBLbMde0pXMbnGGyd9Rvw87Rr1ruKTF8IlNHMnkNM49UfgZ93cYf38eI1m10RVvQ6p45MixjYnurGZluKIbAmQLMEV2OhChbfZBcE/j32+RrZTQNRF9yZFxUSdnbnWiJ2cmT+8yyvc+pPWl3jky20f2dTkon6+NaA9K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626812; c=relaxed/simple;
	bh=O9Md3w7lNMp3yThfL4xFtXu53Q1Q5xKPg+ZTtqtQvSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVdIBho66wl+4HWALO1OiyKQ5rIKXgP6HSvi2DLinzImeFR3qSV3UbrJSM0sx/I0rOC5VFE0kzynCSckXwlovWAiF4W4jtTzpZ/c4jUXP0M6TDR7yM55X1iY0CLL/Yixtuqq/OEVrs/GLF9elmMqL8HVi1cYY8pIzanrVVkmBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Jgg/0vDm; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Jgg/0vDm"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88860551e39so122215196d6.3
        for <rcu@vger.kernel.org>; Mon, 05 Jan 2026 07:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767626810; x=1768231610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECBBJ6POzfhfzDwCrm5/OLG6dFv+kKLqVuVdBNepvg4=;
        b=Jgg/0vDmYeOLvuAWS+1W30chAHl9LAy+Cr99UOgeOTqgAQQkzaFjRq8/4OjxoEbVeb
         tXT5iP+xbGjVtbbzmMxx16lQDcL0554mB1Lq4QwdAj2xN9c6eUpY0ZDeU4ccWtEX8hVZ
         KLpNf5OeP2cZr2NmGUSL+7LHAU6lhyvb1s6gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767626810; x=1768231610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECBBJ6POzfhfzDwCrm5/OLG6dFv+kKLqVuVdBNepvg4=;
        b=brJBCm51EnWdxqPJDLDc+FB5o9i4zHSpAtvFlDFFf1fJGPSCaKBdGlPbd0a52Bq0As
         yg39VgKTrhcF/NtiN21QtUJ0Wh3e7pbSN39O5EQHFUwhHQQ9rBkVidRBwnI0Z1eX1RuJ
         lf+VEHRKraQWmWo/XidBr9S53euqz/6v3q5ItQI6u4o8txGWNZEuawbPTcMlTJ9u8nLR
         h+h+4l+4O4VUAQLNG9BoGd7bgcvGkjPD78t+kbDQ82OzfZdQGde9H3yzdy8dMlzYU+ci
         kIEkwITc+e4OvbsKY8L6j14/Sml2yjVm0ds+Eo4me2RPeLNZV7b8qqU4MYxmCbgCpQSJ
         qR/A==
X-Forwarded-Encrypted: i=1; AJvYcCUr7KN7DbeDyt/pk19Ob/t4h1UjXFgyCbRrMtpn7n2W2GoHhFsWYq58GWhNrssuA+Y/uDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHh9wPB6Ij56lfP0ufC+zlXnQ1An6CFi3++bSUtUMUJOQpw34
	JcPpxTPSlsVLxUyrKUyUm4qppef847+D/SXTFhSbtHKiKnH2r0TR2ojMJUycFdK1m6I=
X-Gm-Gg: AY/fxX48OMMRytVzPa7Ls/ItZ50B87nO4dlMq0QyZ5bsC0Tsm3xMkhxlG0D8cPL98c1
	F5CqgT8AQ1V+AePxusxBRImYXGi5L+kTDHPpPRzTx8XkstecLAgXG7DeA32IlWG6Zectpaco0Xi
	2CBqJvhp09rL3WmdKmNsvWI/kGL3vtYpK1NAFD9u0CdfQBMQNl5m0W5/fHvFPGAWLQnzdZBiXtP
	Z7cfnd3kIa1C2TF6U29uF1C2qXThEVStLeaWYvb5t5nd86adtIOC7e5CIeDCPH8/2/jANHPzmBX
	n9/is1x40enN/sMLNo9AIErtDtXAu84t2uSK2xpjPs3hjYonFrrdHLwHfjHpc/WCB2GYe80n4s0
	cdyRxjGeNrt+VOY72NIcyXJyqMCyjVUFWe/WWuET8zdNwqaQ7b+vRZziVGxKc/jYur9N5EKdWdN
	B8vMWfCnmbYdBKOkGa1LhJxsV7eg==
X-Google-Smtp-Source: AGHT+IHyYqBQIngprr8F5e7p/iZ5wE4clnripTijwzPoRX5WNcQwXd9Vjk+PldWi+443V3CmWMgumA==
X-Received: by 2002:a05:6214:488f:b0:88f:ca98:b00a with SMTP id 6a1803df08f44-88fca98b1bcmr651727396d6.49.1767626810036;
        Mon, 05 Jan 2026 07:26:50 -0800 (PST)
Received: from [192.168.0.99] ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa7088afesm462931cf.8.2026.01.05.07.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 07:26:49 -0800 (PST)
Message-ID: <db14215a-c545-4e99-a380-69cf24841a84@joelfernandes.org>
Date: Mon, 5 Jan 2026 10:26:48 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/27] rust: rcu: add __rust_helper to helpers
To: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, "Paul E. McKenney" <paulmck@kernel.org>,
 rcu@vger.kernel.org
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
 <20260105-define-rust-helper-v2-16-51da5f454a67@google.com>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20260105-define-rust-helper-v2-16-51da5f454a67@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/5/2026 7:42 AM, Alice Ryhl wrote:
> This is needed to inline these helpers into Rust code.
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Joel Fernandes (NVIDIA) <joel@joelfernandes.org>

Thanks.




> ---
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: rcu@vger.kernel.org
> ---
>  rust/helpers/rcu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> index f1cec6583513497e996f74835ca2c6c3f4a8c954..481274c058577276e20093a1014fc49f4a40421b 100644
> --- a/rust/helpers/rcu.c
> +++ b/rust/helpers/rcu.c
> @@ -2,12 +2,12 @@
>  
>  #include <linux/rcupdate.h>
>  
> -void rust_helper_rcu_read_lock(void)
> +__rust_helper void rust_helper_rcu_read_lock(void)
>  {
>  	rcu_read_lock();
>  }
>  
> -void rust_helper_rcu_read_unlock(void)
> +__rust_helper void rust_helper_rcu_read_unlock(void)
>  {
>  	rcu_read_unlock();
>  }
> 

