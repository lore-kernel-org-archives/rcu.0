Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97671481640
	for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676611; cv=none; b=a9WPkug/WJlbBZ3i8VZS2J03d5OG/lfTRzLzhrw0rQSez8W15NXCudKqQZt3MIMaRF68nNkQnHRwVOjZ/GjvFyZpw93iLUptFAmhtsqSC8eHiLkKNEt2PLn6vCJ1xducjIo/7XKQlatYn2p/7fE7CD2e9RLhYWBNxDfHGXsH1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676611; c=relaxed/simple;
	bh=HYNXUsB2uQKx6WmfB1vyxuzhF75cv1aFTHbCNnrj5Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/lrblh+84t6EN+NOFG1anBu9byox9bt+GZqmoRJuFt8j+rjXRrp/dndtEBWI6fclK+eF5eJZequ7aYt/TuNLEPvP/P/NXO+Syh4vzGth64sVv811vQ/v6zwMrSdZGQdZ7cAmtlCxHW0D1FJ+d88W3KtnXXV+S6JN63JxRVkvFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRizO/qo; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRizO/qo"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso4130722a12.0
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787676610; x=1788281410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTpXFws/17fqlPjv0OIN6o8pc9ZoPsosAECq7QPol2o=;
        b=CRizO/qo66ioR+XbGpgaoZLSLDBaTkIy6Y3j13vhftM+512MUW0FmXwjPiPR212/kD
         XwE0IngIOIaggy63TL1R4/m57HyhdDltnEV+JeiSeCh3TciN6Ywq+EDvr3u7HhWlg5Ue
         JnBwHRz51vPmGC5QD3huG9seaasIbthSGr4UKcgW+1F25zFkWNrDjrcXfbyBoXB8vri5
         1vCzNuvwppYq/GJz7kF2goRoggXmiKNuPZpUnN7VPN/F6wHl5CPDRWJ0Q7Z4sD1fDlAU
         k6JYuxo/shI6XwrWLxqA5mI8H6uo7/ROOhRTtttCMPT7Rbr/Ft8K0LG2WZ6306sNyHuj
         6ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787676610; x=1788281410;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTpXFws/17fqlPjv0OIN6o8pc9ZoPsosAECq7QPol2o=;
        b=Y4Dt1/tIpDwPzerECG/+YSIuCD4Y3p/bbCnsYfDAm16XOXwjO+RWn01qZTfG8+WFz8
         hlSp2uLTmLi8x62DDxPgTzobekOWgVf8Vhb8aMbO741xqWJH0/TxTyqWfPjV9LeezjCl
         GqUvQCgjzOp3sovs2HUz4gtogaHY+HuPFNQoLgjJX2ZeOUa9XFE2kYJ7tCNvQJpr1TF0
         xqQ7zTKeDETYAHbfg4D72icbmwOJPFeDyWUsyS2RdPL4I+qfpIx36j+2R9REwf0vMqel
         kxHViFlXM/16/pOk9aCfMXwL+xn5evq+apmpIgLyxbb/8TozCOzUHsgfpWUH7TfUaX2A
         GkEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRQttN4f8MDSEkDJ0KoXBS3nQYmZ/Sqr84i62LAOkCQRCzuW4PuQPlfApyqyQAMbkcnV8=@vger.kernel.org
X-Gm-Message-State: AFuF++n42Iun8MmSLEM1AUsQyaIG8xAheLCSDnsHM825fg5/X/DdgvDz
	nksAT/k3srgtEsiRT9Y5XkURfzsXTCuGy5BpWr3kiyrRLPhCbrjPZU9t
X-Gm-Gg: AR+sD13uaeWp+XorM4kGRWppeqGW1b4XkfOB1XJl3f1CM8MKbG4Cp1fGv9mNFDvYY1A
	FVgeS0INLVFsl604FUyCN0bD7vJKalsZUFy8WbgnkUjyBqMY2frY6g3h3/B40zBXKm/pKFT1yjJ
	+tojsnKK+t79++7a1dxcIOwYB2gOFOVhtB5PxIOHi8lKK2ieAJF6ATAJ2GY5pdbIeyWbNT/TDzL
	cbUuFQ3DPNqIkvJ2yclSuuF77mOmfRek64K9hwzwBzdGknHUD422xrf/m7+y6f16l5cReRba2vE
	CaZYHec1yLftOb5wzwLJJXTb+Y9oNtQ4mxQ9LhglSkjtifzqG8X1sYvGnq0z8+R8GSybVUgy7Ma
	flfXa3MG6gyePAYF7jBw2CNlZUlxtknAe7YNxJp8yks/QPTMIP4fri02uIvGDlc1lqFQGVX/k3f
	9/+wcg4UuDI5LDOWpPMIJ/MTzLTY3iR3rjtRArDfS5eBJ2h5FW9MYtC0cjY1YEFtz9y1kK
X-Received: by 2002:a17:90b:390e:b0:38e:7f1b:efa with SMTP id 98e67ed59e1d1-3966d5d9a71mr854363a91.11.1787676609663;
        Tue, 25 Aug 2026 09:50:09 -0700 (PDT)
Received: from [192.168.55.196] ([218.49.81.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a5a55esm389792a91.16.2026.08.25.09.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 09:50:09 -0700 (PDT)
Message-ID: <24c0edd6-3cdc-4536-ac78-394bf785aad4@gmail.com>
Date: Wed, 26 Aug 2026 01:50:06 +0900
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
Content-Language: en-US
From: Sunho Park <shpark061104@gmail.com>
In-Reply-To: <494f3e0cdb3692bf13690f4cddd3b40098b51627@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 21:33, Zqiang wrote:
> 
> If srcu_barrier() be invoke before srcu_cleanup(), and after srcu_barrier()
> completion, there are no concurrent srcu grace period start again (e.g. call_srcu() calls),
> the timer_delete_sync() should return false, the rcu_segcblist_n_cbs()
> will not be check.
> 
> Or did I miss something?
In srcu_gp_end(), delayed work timer is always armed in SRCU_SIZE_SMALL 
mode regardless of whether its cblist has callbacks:

	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, get_boot_cpu_id()),
					cbdelay);
	} else {
		...
	}

and with cbdelay=1 (the non-expedited path) srcu_schedule_cbs_sdp() arms 
the per-CPU delay_work timer for the next jiffy. This includes the 
srcu_gp_end() whose grace period makes the barrier's callbacks ready, so 
an armed timer is left pending when srcu_invoke_callbacks() completes 
the barrier.

Thanks
Sunho Park
