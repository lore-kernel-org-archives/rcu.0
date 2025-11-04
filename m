Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF52FE572
	for <rcu@vger.kernel.org>; Tue,  4 Nov 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239636; cv=none; b=ZvhOStb1OaMc3/OauUWtmE4FNZP+0yuCLwtu7h4de+bTq2WQ8f5hNARiwWYhU6QjDBqUDTGlm8/dtffaIc2/Ed761gU+5ZxT2vmwfPR0eZxtStN1k+St3SEYBJM9T40vdbeWHVJgAn63t428zppEPQpC+eCuTcyuH4nHTUUIf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239636; c=relaxed/simple;
	bh=Lmg3dsZX5sBPU+87vVUFPw6v+4JP4m4mRIzteONc3xY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NS9Sk9ToL7eD9g94ExxXJQYDsB0TaZVvwc/e17M/GphId5j+neC62PCGg6qc8/Wb0ngzJu18ABclDzmZyCNsQBAHi2Mwj/QICPxM+R7l11U0iewup8qiCA9FeF6aC5lcQF2mu+OckMypDuuoGN8vL0Uac2qFe5Vz2I1PJaruK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzgbiKld; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzgbiKld"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34077439166so4534648a91.2
        for <rcu@vger.kernel.org>; Mon, 03 Nov 2025 23:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762239634; x=1762844434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYJY/CCyWXdpODdd8/1XVppqC3rVXb5NLy8uDvNpLnk=;
        b=XzgbiKld6aAZbyiee1/3OB6fFR3hss/nAJiWE6kjzpIlhlCrYhVdghLvL4Z3CdTRUA
         ZGGj98s2TBeK00khw9UVUgKUI4xTXIO2sCW+qTA0W3c3RPBww/x/HPsBabni0Hmagog2
         t7pFF2NTRBObztrutPKnc1yy3Sk1ZGvJhhsJODZTnRPk3BbOI+d5GfnRlp5dw3Z6jXQE
         eQu1I/3PVuApYuVmPyQV5tlgTETtRrwfkEFyJebcx6JAsWhkkjpoojEsAUU8lY4XM68t
         +/+JSJimvLpjL1NIk0RNlF9R0IUdRo7ka0FEtgKPTmM0/91lWSK01FWtQz4cKNT6NEBJ
         J83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762239634; x=1762844434;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYJY/CCyWXdpODdd8/1XVppqC3rVXb5NLy8uDvNpLnk=;
        b=vRclEiJPRgNdoOKItcmhgDMtlTNDun6tT9Nf5eLWS9Za0dnP+iiO1BTLhd6pGG3KSn
         4yOw7LIn5YXuRQrCkQX+YiFB+UAQ0pAtDSGgblZLvcSP/fW7Uf6ekBDMRVr53f9scHpO
         cIoPUwN2jhyb3J435jBH3cJXjQ6CF2rdpMlVeEtEvsqttbuBq9ju4/5CzF/OASYxIMGn
         Cqhf6xBLsnB6s1F4B605EUgtf5Dv1942esHpivc2NlgIG7xJCgp2hzp5OcI5lSbwdftw
         H2Z5PRTmHwyzFVHiFk5nvWtnycorzg1GnIvr7tnJ2blFMLC0UX6SIICL31yoOTuDB+mf
         0cNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/vNy5vLHnErOwm0h4oJn+NlB9Wb0P3zYLFPkKtemGG8ioYFYI0/Aynu/QUKI7dvBGeIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKzcgNREM1Iyyfx55xW76jkB6/uJK3Zo0j6XSY6CHWPy8g2pA
	DFYU/mm4OV+9FFlqxo8lMnqDOFSQB4UOwEoTE3hdKAblCUQ/MFNmdZZJ
X-Gm-Gg: ASbGncvA+R9rIekXOxWjk/voOvTXMlJ+/XNoHUzsB7u/sPGjjS1enOIsbxRY+YBhFiE
	PSsUrIOSayMcwTbC9S5YRDsevwPG6q05SYF7/AFBfAt3iz7bmiCIlabPsypTd0yBAiqGtPEgMTU
	+twfzJmgdpUppQnnG1djQGHNWJxKEf8yaf7lrB4Glkg1IhhM5mjIcPWYE1SynuDGvDaPnA9LBf+
	tTEbV6AnXXP1dOL6/sIK5p3oXgZTkiAguex9Yf2BbmLI3s8AHUjbHp5Ee5eCJzcCLtirCtx9F3O
	2scg3SDbd0J/+0/fyJDNxtvaAvVmhx/ky/1lt3rrWF8WlvX/AS/mFwY8UsDA+acTBsJcn4AV5BP
	c7TVyS7in4o/MhnugsEkr1zn3fzaC8vL2qeQWpkWyOlifs3ju7f2ESKIv8hSdYm19uewVNZNYfr
	ymONfxdTN/GvZN+ZhIyl36nXs4bTF8cHrl8zbzSigA/BnmSg==
X-Google-Smtp-Source: AGHT+IFuippdkSZdZbM/zbViKxiB1sV+P3foKWTH4k7vkaZ/0vpIhwnIYOp4owTWQeoz9RLgVonuMQ==
X-Received: by 2002:a17:90b:2886:b0:340:73a2:c840 with SMTP id 98e67ed59e1d1-3408308b4f8mr18356520a91.30.1762239633674;
        Mon, 03 Nov 2025 23:00:33 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417bc8e9b7sm649825a91.2.2025.11.03.23.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 23:00:33 -0800 (PST)
Message-ID: <e951d365-27ec-427c-ba29-8b6925342463@gmail.com>
Date: Tue, 4 Nov 2025 16:00:27 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: paulmck@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
 rcu@vger.kernel.org, rostedt@goodmis.org
References: <20251102214436.3905633-15-paulmck@kernel.org>
Subject: Re: [PATCH 15/19] srcu: Create an SRCU-fast-updown API
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20251102214436.3905633-15-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paul,

Minor nitpicks in kernel-doc comment of srcu_read_lock_fast_updown().

On Sun,  2 Nov 2025 13:44:32 -0800, Paul E. McKenney wrote:
> This commit creates an SRCU-fast-updown API, including
> DEFINE_SRCU_FAST_UPDOWN(), DEFINE_STATIC_SRCU_FAST_UPDOWN(),
> __init_srcu_struct_fast_updown(), init_srcu_struct_fast_updown(),
> srcu_read_lock_fast_updown(), srcu_read_unlock_fast_updown(),
> __srcu_read_lock_fast_updown(), and __srcu_read_unlock_fast_updown().
> 
> These are initially identical to their SRCU-fast counterparts, but both
> SRCU-fast and SRCU-fast-updown will be optimized in different directions
> by later commits.  SRCU-fast will lack any sort of srcu_down_read() and
> srcu_up_read() APIs, which will enable extremely efficient NMI safety.
> For its part, SRCU-fast-updown will not be NMI safe, which will enable
> reasonably efficient implementations of srcu_down_read_fast() and
> srcu_up_read_fast().
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  include/linux/srcu.h     | 77 +++++++++++++++++++++++++++++++++++++---
>  include/linux/srcutiny.h | 16 +++++++++
>  include/linux/srcutree.h | 55 ++++++++++++++++++++++++++--
>  kernel/rcu/srcutree.c    | 39 +++++++++++++++++---
>  4 files changed, 176 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 1dd6812aabe7..1fbf475eae5e 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h

[...]

> @@ -305,6 +315,46 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
>  	return retval;
>  }
>  
> +/**
> + * srcu_read_lock_fast_updown - register a new reader for an SRCU-fast-updown structure.
> + * @ssp: srcu_struct in which to register the new reader.
> + *
> + * Enter an SRCU read-side critical section, but for a light-weight
> + * smp_mb()-free reader.  See srcu_read_lock() for more information.
> + * This function is compatible with srcu_down_read_fast(), but is not
> + * NMI-safe.
> + *
> + * For srcu_read_lock_fast_updown() to be used on an srcu_struct
> + * structure, that structure must have been defined using either
> + * DEFINE_SRCU_FAST_UPDOWN() or DEFINE_STATIC_SRCU_FAST_UPDOWN() on the one
> + * hand or initialized with init_srcu_struct_fast_updown() on the other.
> + * Such an srcu_struct structure cannot be passed to any non-fast-updown
> + * variant of srcu_read_{,un}lock() or srcu_{down,up}_read().  In kernels
> + * built with CONFIG_PROVE_RCU=y, () will complain bitterly if you ignore
> + * this * restriction.

Probably,

 * built with CONFIG_PROVE_RCU=y, __srcu_check_read_flavor() will complain
 * bitterly if you ignore this restriction.

??

> + *
> + * Grace-period auto-expediting is disabled for SRCU-fast-updown
> + * srcu_struct structures because SRCU-fast-updown expedited grace periods
> + * invoke synchronize_rcu_expedited(), IPIs and all.  If you need expedited
> + * SRCU-fast-updown grace periods, use synchronize_srcu_expedited().
> + *
> + * The srcu_read_lock_fast_updown() function can be invoked only from
> + those contexts where RCU is watching, that is, from contexts where
> + it would be legal to invoke rcu_read_lock().  Otherwise, lockdep will
> + complain.

kernel-doc (script) complains:

Warning: include/linux/srcu.h:341 bad line:  those contexts where RCU is watching, that is, from contexts where
Warning: include/linux/srcu.h:342 bad line:  it would be legal to invoke rcu_read_lock().  Otherwise, lockdep will
Warning: include/linux/srcu.h:343 bad line:  complain.

Leading "* "s are missing.

        Thanks, Akira

> + */
> +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_updown(struct srcu_struct *ssp)
> +__acquires(ssp)
> +{
> +	struct srcu_ctr __percpu *retval;
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast_updown().");
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST_UPDOWN);
> +	retval = __srcu_read_lock_fast_updown(ssp);
> +	rcu_try_lock_acquire(&ssp->dep_map);
> +	return retval;
> +}
> +
>  /*
>   * Used by tracing, cannot be traced and cannot call lockdep.
>   * See srcu_read_lock_fast() for more information.
[...]
