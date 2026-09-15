Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06732414A16
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488200; cv=none; b=VnQES1JnuLjIut3CoP9iHcr0LMHHHMz5vBPeILMkp6qadTljm8dCm2RLh8Qgl3pK8WGEoyvsHtmNkJQTaDgw/Z1IOo3F615v2lGHHU+FDjcgsIPD5sgqol/clphvFJ0pbU6qH7bxQo5JPFt8hSu0TGcGc+crL13bkifmjtugMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488200; c=relaxed/simple;
	bh=D3oau+TXcYzBPkd1gtd2LCOxJTWWah49cdKBmX9WcUI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s152Z55ynLbFsOmNYI8LqYFGZ37h16IGX4ROYZyM5OEA5pLb8jjSxVT49yn+Vd7fsyQuwhZtRQaX73OvcJqcrNtQpCjb9+hR+Q8Bk9ML3nSIcJWo4cvunVn2oMkrGmESJShMw7MyER6s2qksqSTXhUOnYWYuwIehs3c43nYvycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=WrecKWsw; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="WrecKWsw"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb4so463539785a.1
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789488198; x=1790092998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D3oau+TXcYzBPkd1gtd2LCOxJTWWah49cdKBmX9WcUI=;
        b=WrecKWsw/pL9UnNB+6SpgvBzs9UZDNBSVMQjqpPLcYi8gcMdyuXveFOdkHwAba5atQ
         REzNN9PEs7te92kUawxPx6MgFH5Qjcs39kHIOotY8wWXQlZZb5XYDbk2jMWjK8nF9lGh
         Zzu2hp8DspdOk9OieOqML6YefTI62cHj81GAMw9wFFkm3zroHxpF3MYxqqcnQOXjsmbH
         P4diycGUSjFkv0T8/nzuHY/YkuSUEx9LgfmCPagcu40xv6YBSaGXLIO79ljw4+/T8M9+
         39U8iYQtCIlepHBVjwUE6Kmn/dZfnM2edaX1ePjOtX4QhI2ZWiQ+9Ds9HY5k+GM4ZZVJ
         RnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488198; x=1790092998;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3oau+TXcYzBPkd1gtd2LCOxJTWWah49cdKBmX9WcUI=;
        b=RQvSehUMDTs6drcFdW2XU2MjTF9yBZQ7o+2F2xwVwcyhKSfJGWTuMm1ondz1ibwS8N
         ZXNNc0jqD/NeqPbAXg+NnrehlvwjvaUwQdfV0Ah9MjtsiFR3r4CfxwUEvW9p52oUeIjZ
         /9c/I9AR3UFxsbKTU1rXU6ZTxUeCeBuQ4jjxO4q127+CG4Qp5VrCTd5PUJqUtHxYUCVW
         5XyGN7X5QZqC36NVeBpKASC6lOgiJa3CzvF8S9L1dcXOvZ3VTg20FRTRrKTnyFWbyOPN
         UnrBhJFE2YHe/CuP6vCxN2yjC+e8FBAd2HegHtfrGSKuGM2CIUjpkfXouDw6UCRlzmQL
         joHA==
X-Forwarded-Encrypted: i=1; AKwUvBwDrIf+5aZT9Z7acWismiWo+3fK55QAsLWI2MXKVXKj7bRrN8k02Y2jY5fbytbGK+yBue8=@vger.kernel.org
X-Gm-Message-State: AFuF++mqPWB/fOzXzUUrNTcWE296cYwo+89QCJrSlgMShsGqsSgiszY8
	UdFbObL1NRTPeyyes9M6vA3KsB+v5B4icstNs+Dly80sc+M++VA5CTYrXPdUtEQv81w=
X-Gm-Gg: AYBFou3xhEvbbRXeNoZAywiyuSqq5Z5ESrpBWiG3E3/lgft1NEumJ+QSbb1fStrjsRV
	4eFXsUrMYemouHZ6Ge+iubbYd5Iyd9GM3xpZ9qC8eHJOLujL+wkyw5XjEFMZErGL7velCSl/OjR
	RNFucMhUNALVaGHj4Q8TMLwh/uvKnRtm3I2nLJI1N+mfwb+LJn07JvCuoeLk3TRmMgUuUKQI4/B
	je6QMbyifw1SDme/KI5LcmElTZw7q5yB3APTmqX3t+uniDJjSof/pbFKLqQXMiNyJOY4T8UXMN4
	dBUkExMJWgUT7RrWxkN6W+4phUrie1ODjX7dMz3Aoz5RXrvzLms6TBLIaOa/enhzzdplpVzM9QK
	OgTxcQEmB5zCfsJfEXEHBKAkp+nioKMWznmeptjvItoWuLrOhJX3DybmeV6uBQ3M4jIgA53AvBB
	3l+k2ZgcENXMsn0iZ5U7YdkNB4qOdXLGBkTecAGiVhNrNVELkr44AbSvFHV2KFmEEFLAys+Xasu
	7mGT8b9IcLAzS5QYnB1UKbK5o8Ucl7GBf6nhmmu40hZgxeuxm+X9Klw
X-Received: by 2002:a05:620a:90d0:10b0:93a:2d2b:a5ed with SMTP id af79cd13be357-93a2d2bb71dmr992381385a.47.1789488197613;
        Tue, 15 Sep 2026 09:03:17 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ec337d23sm1222565385a.2.2026.09.15.09.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:03:16 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:03:12 +0000
Message-ID: <da00ebd18989a30a9dfccff23be9ba14.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v3 05/13] ftrace: Mark modules hosting direct-call trampolines for Tasks RCU
In-Reply-To: <08596bcdd997ab7122dafdb363cf80caaf038378f32ccb89fbca114c2fd9110a@mail.kernel.org>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-5-0ad30c4c5ee7@toxicpanda.com> <08596bcdd997ab7122dafdb363cf80caaf038378f32ccb89fbca114c2fd9110a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 14:17:49 +0000, bot+bpf-ci@kernel.org wrote:
> This isn't a bug, but could the field and ftrace_direct_mark_module()'s
> body be gated on CONFIG_TASKS_RCU_TRAMPOLINE_READERS instead?

Sure, done for v4, along with the other three from this run: the
rcu_read_unlock_tasks_trace() lockdep ordering in 02, the @regs kerneldoc
in 01, and the Documentation wording in 13 now mentions the
rcu_tasks_trampoline_text() / rcu_tasks_wait_irq_preempted() route the
kprobe optimizer takes. The kerneldoc here no longer points at the sample
header.

The Fixes: suggestion doesn't apply, 03 and 05 are the same series and
nothing selects the option until 13.

Thanks,

Josef
