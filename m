Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34922D948A
	for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180299; cv=none; b=WlhD8bU3DWJvC+d6YzvOEqydTL/sxl7+06ngv4mKOJi//gh8tfp4LzdVftYyIknw0JuyiCGeegF2E3xtn1mXV66TQCAFmXRCd1vekSEfoiO+lgH/r4nzgALO6ao+isYxKj0OC3FtoflDphsFzzpMGECwM7YmosbMUMaBmEXl6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180299; c=relaxed/simple;
	bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7HgIs7EHU1emPMsDMuz6qHeUfHbTlAlhQVn35K61XyqzH4JoMc3jSo0dsdO7pG8ayLOYKCgLRZJRCsi2t8Oxk+vvuELgqvs18VJFghhaSlIil2D1XuKAJOIpLRZlPtprfBINX7A7gpCNab7t7TVB60c7p3KddAitk9xdwNhwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZXXDITX; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZXXDITX"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c21417781so2201147a91.3
        for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180296; x=1766785096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
        b=PZXXDITX8O2pITtu53MVdLOAN8xLa+E4T8O59SLKUmlhw5IGVuOVSaPVKr3RLgyRi9
         FFkrGh/mG35OypARILyigj6YN0GxLJ3X3MOyK+Jvg6PjLDf3Dq2LmoZ2Sj9s/vukVIFq
         LzzBAqPmENgXRvU7eSOKxVcijftEUHTO1jAq7CC7D0kpCfHRoPh2jBjS30aoCTlf+rtk
         nw9MA21zYZJBvVw3CEwwUHEc5WUM5bMNKamyH44/Jthx3UNRJwNqNDyGqhB/ZUDiPjj8
         /SJ5Mj3VpKOHOujtfOTulYT13laYJWXVJsjSmabdQezKKZkPMS3oWx9RPm6XWm7dEXsO
         n3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180296; x=1766785096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
        b=vIrEB48yOn1I0K03UzVrhSWNDtvGuxuQJ+EUHQe1CYFoPk4KUXDjVaeOXZx5DKHtXE
         fw63fbzGNnrm3ENsfHzxvUvs8rGmAcILArEgZJq4Rr+7pIfLvBazf68iqCra19bhQV+T
         3bqyUVTCMUtQvRf5ZhIT+AZbRWd2mlLWWPKU949X2QjfJlAasG48mU0yfcE/nNqVTheH
         sKEMKT/vtcSNRLZxhPnmd863ldhgGDCUpSNbzr9f1xYzZx1C/jmfO9vKnTNzOmEAOxtI
         k0lWBiE6qW0XsvfofygMiKVbuPqlP91A/I7M82QWt2jLqHDA4qk1l2AeuSpSEwDlniyW
         2SGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJxU1VqwOMW6bSA+VXaAUDYMCQhUwrC4NLyG0M1CxeC/uOaYc6rKL6fqLVp9Op5vAgjEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/ddxH5nV5nN+ZXeLyxgXsnxE7s77IKM9gG7hlNar/tyJXyhZ
	lGyBSzhyy6NSsBEog2KiU5VNho56tNVwwmdJXTJSazuBfD9S0ywF4BBJ
X-Gm-Gg: AY/fxX6t+U2E5DfWLG4jElKs8J90gpq+cDNtzHiDdmDZQlxbeHCWUq3YuKHtExbXQwT
	jSA9PBn8HBCdecI2KhVmBBt2QNEMq5tgO3+6+oxQ/OTgPzh8kz4uGCkDDA73KRjs/XwNOtmeIyC
	ns0Pj2Ij0ccz3p/yLLbCeo8fJEpzrjMpEhR5pnpjPPcWa3ovlPvgxQjmO1xmZIzcjvXcVQ7Gxzs
	nJBNMbTWFBjz6d8xciU1EQhK28ayr8mErwFndpF0hadN54YBDhCWHFAbexGh8Ntq5dn+h2b5SgE
	tc+EucaNneoE/i7lgWIgnVTzfLM8vdmAV1zQ31yZKVRzMHcnqSeSygIZnELDtSbI+CXA1RlpHoK
	+2TsHGa7E9ovbInCBPQaYWvRFj9I4DcL7vH5j4WdRDBqonI/vw+7yoTSmI0xSaSigJGsMZRhm4t
	kCuukeVn7+HGQJLQvw2Tt25Zq/gfcZk81R4CIBin9LW+R7CmMn317BtLw1n5bmhPaiyssZe6sC4
	rMNWiMzq6umoC0AcNq9XEKqXtGrjIcA6WaWeEIkXVMxeGBw+fPiyV5dQpL7wEOouCatylLZumu7
	Z0Y=
X-Google-Smtp-Source: AGHT+IGivulZwqOvq9TkwT/0JBobQprm3JRJ6VtJUw4ydSXEmlT/iKTWxEeMw8/Q4ZWRYLdEwZEKQQ==
X-Received: by 2002:a05:7022:e0c:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-121722f462emr3455845c88.28.1766180295388;
        Fri, 19 Dec 2025 13:38:15 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm12051531c88.1.2025.12.19.13.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:38:14 -0800 (PST)
Message-ID: <34cda24f-acdc-4049-9869-b666b08897d9@gmail.com>
Date: Fri, 19 Dec 2025 14:38:12 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/36] compiler-context-analysis: Remove Sparse support
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>,
 Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Triplett <josh@joshtriplett.org>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-24-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20251219154418.3592607-24-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
> Remove Sparse support as discussed at [1].

Kernel patch descriptions should be self-contained. In other words, the
conclusion from [1] should be summarized in the patch description
instead of only referring to that discussion with a hyperlink.

Thanks,

Bart.
