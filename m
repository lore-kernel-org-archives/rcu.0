Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D12F84F
	for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833850; cv=none; b=opnfkMQRwIuqPiaqs/2UZTXP4BNFMVflWTZW+5uZvoadSwQyAXXZvp/3OctDkWyg9np8FwEBA1bn0ZFMI06LRMXUCDWUvvUeLs99PSIbmHeAoPG4dnXLtv+qsmC6fr4p21/c6dQQSsxwXspnNMW4zPuM0Y6tROL+vilx2XXXJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833850; c=relaxed/simple;
	bh=tPcB7pxS1CtvRI6+WBWltqzW1/4bgDW/w7xXAskR9sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3FFrD4wg/6sRfT+W6CitQqL81jiGwf42b6pieXQHZWD2cjMgDLx8s6EhsNpj9HBe9qggc8RfwK767aB5Mm8vcLERSWWDncmplMxOTgKHyX9ubzCW2S4DMJ5q07RkFsvKnfjIq+5uu/TI7fQckb9fMRF5bLZZcPakmZd6qF9PZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmXLvgRv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmXLvgRv"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39652a6e963so852738a91.0
        for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787833849; x=1788438649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3z3cMsrGZIG1otUxfYnwtzC7nzo/8Ajm2RUqvlxc68=;
        b=OmXLvgRviZv9iQFdpXyZvQx7q118p/Be+kvDRmS1S8BNqz8qe7ctqwsV/XxJ2PlXFk
         bLjSiGvovaDS3+08UwhHWjmrDH5+8JLjF2dnXKRA4jrKDtGC0XVDyexpnuoOwdMJR9Kv
         bRcHYpObgruY5KvDcFqmfMnWQKq+tFbk2yxc3D6o9357igLUGHCaYQCGA/YesGdmbn57
         j562bIHZjGKtckDuGoiuFCqdgi8gNcQBbsvU/29RSX69Jx6IWZ0FUnA1I0k8gaj0Dne2
         XD8gw9WYuPiGk0vkSDteZ0sdWsPKoi7zYvF8XwvurbBO2C9OqhRPN7uvUlPjbjSyY7vK
         Ju8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787833849; x=1788438649;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3z3cMsrGZIG1otUxfYnwtzC7nzo/8Ajm2RUqvlxc68=;
        b=fMr65sVQTNd7BMzGKaA1VZeM/OgcvNrnjfqWKSwoBAOk8d/ZRBL2f6aFNK0CM57Bc+
         A583koXf3fO6Jxj4NyjdQPAE5HXmjzSsiaYqVRD0OTF2NG/2e5hjjpqprnZCrd+x3MyS
         M4doNeK3VFS8xScAYxI6Lpq2T4MaEP4fshUcxuuiEAXjHrh3CCLvxvE+OryEPZpagqVM
         NnRdR/v4ObR7E+cFaP2Elyr7Dg5hHqtRy3sYvz/QL1BYTd/pFOnTmorrPCB8ofpqGkyq
         aVl4J1ssbXjUay4IyjEThFvHjI/GSjWIUOeM54cevtqxOqfWNUBKe+x2CdUT48FfzWos
         KU6A==
X-Forwarded-Encrypted: i=1; AHgh+RorCLfCBLutyNqEN8EyeESoA6oOVKtfWP/v6gCZSpstiZ7+l+UloFWDpnQZaofq+luOTC8=@vger.kernel.org
X-Gm-Message-State: AFuF++lF4olB51gPKn+DJD9sTuw+BVSTq3au0vPBGI6MnlayHPkeePjW
	0XOGcNc1RRnjtxGtyHz/pCARfzrZUbnLf6wP3kTrFe0auyX7qadw8Erd
X-Gm-Gg: AR+sD10YkTENbtQEssjFawmRPYVefGZqhHqMg9sSz611YGGV/mzhhGFnLZg29eQyHO3
	foTszLj12hPvkz+3kxIskmXQwC7AbaBKGs+jRBA0GXsro0NmcbEE6W9r5Afx50go+j3cWPlljZk
	eBxVpZ68vkMu5sQm9SDgjWoAXqOVIcN+ZUGtTbHc3EoJXmtGOQRtEZMy0uVIJdb9eMP+8tckJ+D
	/IVqesWrqr6fpbjSIsDxbxkX/fk2/BlPE+nHOhVHDOcKopfy/g598Kx8MEqtcB8gfiXxAHZSmE6
	5/2DKJ+ytu2jHUPl72NKB9GMbqFkEUJb5QHBdAt48qfBrfLBE5utKMnA04/Hwi23Ju9XC2BONPQ
	uuYErvMTgviUtDuFbqKtpWOr4OtqBNrLQnmJr8rnVk8hLH3UWDKGE+aVVFPvA/9fsSSOlKsFVgi
	4DPcdjF7TwnoC61nbZyfDQpm6IL+frSg4CP8DlROID6EqoHvJj/XCbcnrScSwXK+0voRA=
X-Received: by 2002:a17:90a:e7cb:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3969bb7ae09mr6471454a91.5.1787833848973;
        Thu, 27 Aug 2026 05:30:48 -0700 (PDT)
Received: from [192.168.55.196] ([218.49.81.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1125ff2sm2735225a91.16.2026.08.27.05.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 05:30:48 -0700 (PDT)
Message-ID: <69bfdfd7-3efb-424a-9146-ca0ed9226edf@gmail.com>
Date: Thu, 27 Aug 2026 21:30:45 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] srcu: false-positive WARN in cleanup_srcu_struct() after
 78a38cbf6f20
To: Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
References: <20260824105625.3725157-1-shpark061104@gmail.com>
 <494f3e0cdb3692bf13690f4cddd3b40098b51627@linux.dev>
 <24c0edd6-3cdc-4536-ac78-394bf785aad4@gmail.com>
 <0e74e6799bf042293fd1e34e2f242c56786c3de4@linux.dev>
 <9e216978-d884-4d56-b39f-d134f78a4999@gmail.com>
 <eb2132ad05cd3804a8f2a170de441d79afa793e9@linux.dev>
 <f85c60a0-81d7-41a4-9926-f69cf10222d0@gmail.com>
 <e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev>
 <698a4d8b6c559f9049ee6fa6b0bc99d45a3d7e44@linux.dev>
Content-Language: en-US
From: Sunho Park <shpark061104@gmail.com>
In-Reply-To: <698a4d8b6c559f9049ee6fa6b0bc99d45a3d7e44@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/26 20:35, Zqiang wrote:
>> Which tree is your test based on? (rcu tree or linux-next tree)
I'm testing on the linux-next tree(next-20260821), regarding the commit 
[1].
> The step5 srcu_barrier() has been intercept the srcu callback which by step4 call_srcu() insert,
> so at here, the srcu_barrier should not be return, and the step4 srcu callback should not be run.
> the cleanup_srcu_struct() also should not be called.
srcu_barrier() didn't return at that point, it returned at step 9 when 
srcu_invoke_callbacks() (which was queued to rcu_gp_wq at step 3) calls 
the barrier cb after finishing the real five __free_bus callbacks. Steps 
3 through 9 all happen within the same jiffy, so the timer armed at step 
6 for the next jiffy is still pending at step 9. Also, a stale n_cbs is 
left because, although srcu_invoke_callbacks()'s invoking loop may have 
finished at that point, the control flow has not yet reached the 
rcu_segcblist_add_len(-len) call at the end of srcu_invoke_callbacks().

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/kernel/rcu/srcutree.c?id=78a38cbf6f20bc8247e93d1149f97c12dba9fbfb

Thanks
Sunho Park
