Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68CF46B8;
	Sun, 20 Jul 2025 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752985862; cv=none; b=lI0aGQfJifqkbdfHzJZothQoh2qoKDySxFLsO6jD0xF4WzD8tJjHlvcTZzZFBQL7OSQFE9pOxd1RtC7AiG+CQzv38P8Sa6rN2lUoQ13bN3GmYeE9L7KA5gZHZY7yi9xdSTKl1gDTcEnCi0eFhxPw0e/K3c24rlEZe/yqw0SDlK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752985862; c=relaxed/simple;
	bh=UDVPM3UKcyEWIJ7xlmKy2EpZUJsVZ4xhm4vOnID0REQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BVvgDrE7APDMfn2o2AszfvgQl1qQPcSeVcers4aFsHHRrRZVBE6iW9uyRGs93k8Pa6XriVWO7t2u281spvKqWIWeLJZM4uw+61UDp9bhwPsNy8G3FqUS5W93eqG8/fPfNC3BeqwXsHfYluQhxlqN9Q7PBvu559j49sQs1F81oCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daBqqnTX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daBqqnTX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso4110375b3a.2;
        Sat, 19 Jul 2025 21:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752985860; x=1753590660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEBitQIZZ8fVSlz2UyPAhSqwb5O3Zr3vSDYZfEDWk78=;
        b=daBqqnTX/CueVOfPTwFuNFeAfLOS7XtDOtqqUjWce2P0XMmIAnN8ifMPyEsx0yQlNk
         fzyptOJdfkDky2kxhe47YbnsuxkqeJOw4g3TCBoZDf50T8bK/Gvw/791CftWzo2I+jam
         xHrhEz58HAWSWbRxdP4AWQXp0pRrDwKvHhPWq2qdkH36MPGlL5er2XC9tnVy3tDqus37
         bfJOiRN+25HiB7wf2PLQR8tNBWEDUa+QfXHlCzX3r9e+LInS1vtG+QXIB+YRSHnFft+B
         OvLpZckIq2tSjfoaMClx02qLdeL0vC2Y/FPCTAlCViaTsqhu6dWrkn22Clh2eA+0zPan
         fC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752985860; x=1753590660;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEBitQIZZ8fVSlz2UyPAhSqwb5O3Zr3vSDYZfEDWk78=;
        b=ZsFIyga06IYGVsJur34xzZ8BX6c4vbQGMok9krwXHydlWuRFUxp0YCU03vewBfvFBW
         qXpT/z7ycA8hvTmuity6BWUzcxoBBErABhlHwT7D3jVlOHZXp9JTF7WTkgftZWW9BH/9
         FO3T0pFuYBQBXt1P+ae1n1l17AANRCWViwWwmoDO0xhbLnTP6sxxf3ZRf4X6Yspbwtbx
         82Vo1EPW28UiMQhHABdDk7P4XdnPVrHLQ6IWSLgtr1CZYRd8v7q7SdndzXayhON40eP3
         KSPnqPYLfM9lWaApP0+SVAyAd29hzIrflPcFFEw0sCXsSp5h7IDmehq4kNPhOShzbTDG
         LXEg==
X-Forwarded-Encrypted: i=1; AJvYcCWJY1YxrJ8vY/jES9SoughJFLFz41ePSS/oIy/c63Y5wF+nfhLByKcvooUyTYNlLrQAgFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIABay9gR7B67xZXpUImEvmrHumblUlIUb7cZxIyoD44n+qzd4
	Pbd//VFHrzBTDGd4PgHusCYVgJpG+EIIHMEwWqgbpulgJ/eZ5YPAklPg
X-Gm-Gg: ASbGnctpE62i6d6Ocxfn5zOc7LgzYT/EN8HDhbQeHsLFrJ6vw3h8GOiZt8sI2ielHNo
	tVUH9zgQKrQTto/zLt+PR/V3SMOqrlF+tZ1qVysiy6KFsFtJMP3fe/rCfSNQmGsnQlyoIDUTWRg
	COUxBKXCekyGszeavHcLizi0PMGYMfpZflZcwAnBm0W8MDwa3RAH3gs2oT0OhXMWWlUOEGCdN3O
	TMr9BQCyCtwDv1lfWjkUP656P/1LAJyaQ6/dsIH6dK+FYcyY4GdJTK8S7xaPnKhQviBUMtEclI/
	XdJag97+ugkXd3G1rk1TzZDxxO3UGPkuIYGk3DLR5lVTOsSGy3zjXiQDxEklHP+F9hY8I9uX4pj
	n/z3OjqiXEAu+xyq2YpLt2y5K4HH5JqtvP+9KsRSfw9/8Y1ixe4ibdA0pu6uoGoAghHNc
X-Google-Smtp-Source: AGHT+IHUg5l3498T9vEcnkKlxtkQ/EtaB58eMnk7ZRkRnuU1bb68rC+KivaalDercmURPh2nwCXY/Q==
X-Received: by 2002:a05:6a00:ad8a:b0:758:284a:9128 with SMTP id d2e1a72fcca58-758284a9165mr19367039b3a.19.1752985860147;
        Sat, 19 Jul 2025 21:31:00 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc6aab8sm3465255b3a.157.2025.07.19.21.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 21:30:59 -0700 (PDT)
Message-ID: <a5aeaec7-d4fc-47e1-b618-e7c768dada54@gmail.com>
Date: Sun, 20 Jul 2025 13:30:57 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: joelagnelf@nvidia.com, neeraj.iitr10@gmail.com
Cc: linux-kernel@vger.kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>, Akira Yokosawa <akiyks@gmail.com>
References: <20250715200156.2852484-1-joelagnelf@nvidia.com>
Subject: Re: [PATCH -next 0/6] Patches for v6.17
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250715200156.2852484-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[+CC Frederic]

Hi Joel and Neeraj,

Belated drive-by review.  Please see below.

On Tue, 15 Jul 2025 16:01:50 -0400, Joel Fernandes wrote:
> Just a repost of patches with tags, for our consideration into v6.17.
> 
> All have tags, and the last commit is a fixup for the deadloop patch which can
> be squashed into the original patch.
> 
> Joel Fernandes (6):
>   smp: Document preemption and stop_machine() mutual exclusion
>   rcu: Refactor expedited handling check in rcu_read_unlock_special()
>   rcu: Document GP init vs hotplug-scan ordering requirements
>   rcu: Document separation of rcu_state and rnp's gp_seq
>   rcu: Document concurrent quiescent state reporting for offline CPUs
>   [please squash] fixup! rcu: Fix rcu_read_unlock() deadloop due to IRQ
>     work

There seems to be a couple of issues in the S-O-B chains of commits listed
below (in rcu/next):

 * dcf1668449c9 ("rcu: Document GP init vs hotplug-scan ordering requirements")
 * bb1c373934db ("rcu: Document concurrent quiescent state reporting for offline CPUs")

They have a "Co-developed-by:" tag without a corresponding "Signed-off-by:"
tag [1].

Or, if the contribution is too minor to have a "Signed-off-by:",
then a "Suggested-by:" tag with a "Link:" to the relevant message should
suffice.

I have no idea which approach suits better in each commit above.

[1]: Documentation/process/submitting-patches.rst
     section "When to use Acked-by:, Cc:, and Co-developed-by:"

Quoting relevant paragraph:

  Co-developed-by: states that the patch was co-created by multiple developers;
  it is used to give attribution to co-authors (in addition to the author
  attributed by the From: tag) when several people work on a single patch.  Since
  Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
  followed by a Signed-off-by: of the associated co-author.  Standard sign-off
  procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
  chronological history of the patch insofar as possible, regardless of whether
  the author is attributed via From: or Co-developed-by:.  Notably, the last
  Signed-off-by: must always be that of the developer submitting the patch.

Side note:
  scripts/checkpatch.pl would have complained about those missing
  Signed-off-by: tags.

> 
>  .../Data-Structures/Data-Structures.rst       |  32 +++++
>  .../RCU/Design/Requirements/Requirements.rst  | 128 ++++++++++++++++++

I'm seeing sub-optimal uses of reST markups in Requirements.rst from kernel
documentation stand point.

I'm going to submit a patch or two to improve them, but I can't promise when.
They will likely be only cosmetic cleanups and I'm OK with it upstreamed as
it is.

        Thanks, Akira

>  kernel/rcu/tree.c                             |  31 ++++-
>  kernel/rcu/tree.h                             |  10 +-
>  kernel/rcu/tree_plugin.h                      |  90 ++++++++++--
>  kernel/smp.c                                  |  26 ++--
>  6 files changed, 293 insertions(+), 24 deletions(-)
> 
> -- 
> 2.34.1

