Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57C237713
	for <rcu@vger.kernel.org>; Tue,  6 Jan 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716957; cv=none; b=I8rpWtdHYPrKou6SFtXEe7QD5nrg/gD/TXZlZoOCzAVsO/23bt52LDnPJ8chLnHoUFItc9l4l3QcyUt+Vm3Hw8RP1/+BQKlHXPrqHmh0qJZtjyrNsuJtAYJ/SPdidoWW+OaspKzQkqGKf9NM+XKY3teDUVE+lYeFQBBvmImUfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716957; c=relaxed/simple;
	bh=swIiWX0Df4zZxGZK71kxmYmdeTeERjBI8MsrrjJ+tSA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf8951FNnCXTRPULNtSAEBRgMCtyI/rlh3QNAQV9NNl0XeBdEvuwbJgRr5xx7rC7zhPH/Qruv6EjsRublGv0W3tMYpI6Gs7e6QyXtSJY2MEEZ7hYmL1CDmtwEsX5b82N99bWzHjinN+QSGEfbeD8FTGFd7Kb7w+sAXUHJeSvnws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKEuRD/B; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKEuRD/B"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-382fd6cbae1so816921fa.3
        for <rcu@vger.kernel.org>; Tue, 06 Jan 2026 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767716953; x=1768321753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXjo20ns/btRqyXbAUKMeNzYrPvs4KmzMCdQ8JtAA10=;
        b=JKEuRD/Br6fek4jYfRKamzwLxmnlLd3+Tb4rjOHOn0dhNh6UqwsIIlNfSSUfHa/d0a
         mx0Xh8YmCy3bqzwq+bLI/6lO+ONuzHG0gEuEq9rF5pzlfAVq7v0nEZlErhkjymVD00Tp
         CaeAdJVdW+joZLtQ11zK6g1kG00/o2XLehLeDIyJ45VmX0Vi4lyMMbCQqwMX935PJAF0
         9XUigHvoU3OxaibBVSQ+x1syECH6rXtJ7S4WcZgRqO2CRa0ZV4nsVBjZ+CnNEs+d9OUo
         z7Jj0V9WTaHo6FA4YFoWnNw0+GkDFKfdf1/PYzq+mC/zfk37xM3S6mFIDYeGyFAOFhzQ
         7glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716953; x=1768321753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXjo20ns/btRqyXbAUKMeNzYrPvs4KmzMCdQ8JtAA10=;
        b=EAhQ1N+puaizHLtRHsoxDBksrDWLSvn9Udziox79efpFdDAUcvqfdEElH9QAhBzOC/
         69Tr4DFSvCqw8MM3IhCSkPMtLCCxLIvgqUrG5PHP4ixX9wYKqkicH61YQ8DEWYL/eEEE
         273mWWwVt42IeHoI0FnCsfF59sXNTX/i3b7ivH7iebh39v+abcoILYow8zRvAS35Sq0w
         Wa8KaFb0kcZWRq5RdvkshZQmwUqZ5R1eCBU75Uddt4tpZsoji5sLWdMEF1HbzsVJPAX9
         xvtUh2b8iHFm47qrXvIDMvt1n+gFDlNTGy3kSV1di2jyrgZysTaFS5rZa596mhB8jPyw
         tSog==
X-Forwarded-Encrypted: i=1; AJvYcCUKfO+feLhmohAH5a/RtwMKORBglz0PoODBlJ4nGQvG8X57N97f8dUoe8A0qU9AR4/OSZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpIEOPvLXiVAUymziKt59XyZn8WgoxN7CMg22doHeLrXhjo66a
	aUJO3Zb8U/fj4yHdcxPk9suss3FtX2SX84VnErcp5mdPxnWpxR2CJQwy
X-Gm-Gg: AY/fxX7G0BJJv00cRARapYw5DFHXatF25Nj3G7sp0kVif3SjHfNPB1QbpwYoPjmJJqK
	FvLoYvfmA1fIoZOv3p0Mjd7o4gz6NqG4x8Miv/cLHxvdjIA37gxNR4gjuDmU+ljlz77738QM74M
	QLHhoiK8l8JyJgqLHPSPWiN3Jxvb8trTMNts/+GLl07SQG5uxg4cFw5h4Ul1MZkc6X6GihsgO1U
	l1bvePeOGbUS+SNopibtAC45vqR9sdLPrqReJCPQFVoVOkdQ7ZRmSzR9RAPm0IFRwLJRRbnNte+
	WxbDh637NBymH5PLqNcgUdZco6zZZiWUUZQcFZ0Nx5xQ07dNYNPUWF5jRdJoc6HgQeg+fwrGXAT
	1/neilgL84dQe9zSNDInPL9oC9mm4ZC6XXX8kXTEQxviQYMH6J2k=
X-Google-Smtp-Source: AGHT+IHjkf0oiOYUAmX3M69uUXbCSTxYOAQRMPrroqUANk4RfbtgKz3BcGQg8rJ5rpourXZo4bsylQ==
X-Received: by 2002:a05:6512:ba9:b0:59a:10d3:7a65 with SMTP id 2adb3069b0e04-59b652bba95mr1193546e87.26.1767716953073;
        Tue, 06 Jan 2026 08:29:13 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d5dd14sm681430e87.51.2026.01.06.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:29:12 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 6 Jan 2026 17:29:10 +0100
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Fengnan Chang <fengnanchang@gmail.com>, Yu Kuai <yukuai3@huawei.com>,
	Fengnan Chang <changfengnan@bytedance.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: avoid stall during boot due to
 synchronize_rcu_expedited
Message-ID: <aV04Vp3nmCg41YZD@pc636>
References: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>

On Tue, Jan 06, 2026 at 04:56:07PM +0100, Mikulas Patocka wrote:
> On the kernel 6.19-rc, I am experiencing 15-second boot stall in a
> virtual machine when probing a virtio-scsi disk:
> [    1.011641] SCSI subsystem initialized
> [    1.013972] virtio_scsi virtio6: 16/0/0 default/read/poll queues
> [    1.015983] scsi host0: Virtio SCSI HBA
> [    1.019578] ACPI: \_SB_.GSIA: Enabled at IRQ 16
> [    1.020225] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
> [    1.020228] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
> [    1.020230] ahci 0000:00:1f.2: flags: 64bit ncq only
> [    1.024688] scsi host1: ahci
> [    1.025432] scsi host2: ahci
> [    1.025966] scsi host3: ahci
> [    1.026511] scsi host4: ahci
> [    1.028371] scsi host5: ahci
> [    1.028918] scsi host6: ahci
> [    1.029266] ata1: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23100 irq 16 lpm-pol 1
> [    1.029305] ata2: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23180 irq 16 lpm-pol 1
> [    1.029316] ata3: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23200 irq 16 lpm-pol 1
> [    1.029327] ata4: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23280 irq 16 lpm-pol 1
> [    1.029341] ata5: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23300 irq 16 lpm-pol 1
> [    1.029356] ata6: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23380 irq 16 lpm-pol 1
> [    1.118111] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK 2.5+ PQ: 0 ANSI: 5
> [    1.348916] ata1: SATA link down (SStatus 0 SControl 300)
> [    1.350713] ata2: SATA link down (SStatus 0 SControl 300)
> [    1.351025] ata6: SATA link down (SStatus 0 SControl 300)
> [    1.351160] ata5: SATA link down (SStatus 0 SControl 300)
> [    1.351326] ata3: SATA link down (SStatus 0 SControl 300)
> [    1.351536] ata4: SATA link down (SStatus 0 SControl 300)
> [    1.449153] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
> [   16.483477] sd 0:0:0:0: Power-on or device reset occurred
> [   16.483691] sd 0:0:0:0: [sda] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
> [   16.483762] sd 0:0:0:0: [sda] Write Protect is off
> [   16.483877] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   16.569225] sd 0:0:0:0: [sda] Attached SCSI disk
> 
> I bisected it and it is caused by the commit 89e1fb7ceffd which
> introduces calls to synchronize_rcu_expedited.
> 
> This commit replaces synchronize_rcu_expedited and kfree with a call to 
> kfree_rcu_mightsleep, avoiding the 15-second delay.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: 89e1fb7ceffd ("blk-mq: fix potential uaf for 'queue_hw_ctx'")
> 
> ---
>  block/blk-mq.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: linux-2.6/block/blk-mq.c
> ===================================================================
> --- linux-2.6.orig/block/blk-mq.c	2026-01-06 16:45:11.000000000 +0100
> +++ linux-2.6/block/blk-mq.c	2026-01-06 16:48:00.000000000 +0100
> @@ -4553,8 +4553,7 @@ static void __blk_mq_realloc_hw_ctxs(str
>  		 * Make sure reading the old queue_hw_ctx from other
>  		 * context concurrently won't trigger uaf.
>  		 */
> -		synchronize_rcu_expedited();
> -		kfree(hctxs);
> +		kfree_rcu_mightsleep(hctxs);
>
I agree, doing freeing that way is not optimal. But kfree_rcu_mightsleep()
also might not work. It has a fallback, if we can not place an object into
"page" due to memory allocation failure, it inlines freeing:

<snip>
synchronize_rcu();
free().
<snip>

Please note, synchronize_rcu() can easily be converted into expedited
version. See rcu_gp_is_expedited().

Inlining is a corner case but it can happen. The best way is to add
rcu_head to the blk_mq_hw_ctx structure and use kfree_rcu(). It never
blocks.

--
Uladzislau Rezki
