Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CB346797
	for <rcu@vger.kernel.org>; Wed,  7 Jan 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804642; cv=none; b=dEDFoUXOk/7qoKdZJ6AsYw6iK4bapf0HzUDkCt+u7u52iy0vAQ2s8YblBP9Swp0VmekZbtm0/PPnqk3L3MOcrubZJ0MvXewCDko593FKvW6USyTPWfLVMYaaKLNzH+hGwjr69D0iKSFbOqBmj+eKKSisqdw7fj7iCbTDdzQlH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804642; c=relaxed/simple;
	bh=Rs+CHfz2pEdJ9ZDzoS58n/HTicuPIYuGFoXpeFE643M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R6GBDqddWPeTtkAEXkm/+qQUxdu7w3FCwO19G5t4Wj3KhKKQOjkTZ5FzX/L9Ag0kOd994HlVgY5E4029UXzw4rnTKdjuDhWtMbi0vkUZOGG+1hHmYeOio4Q3FX/SeWZEvFCPUcuITip87u1s3uEfDZUh1rlq1KD5ryJWbnxK22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XmY22dUP; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XmY22dUP"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7caf5314847so1439909a34.0
        for <rcu@vger.kernel.org>; Wed, 07 Jan 2026 08:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767804631; x=1768409431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSTQ4KUiVWxTX9B5UYC0FohSYWYTxrtxwk0QjL7KUTM=;
        b=XmY22dUPlJDG8dB3YdW1TSOXup+kUK8A0j/nJmah+afBZ4Y72ho0RET/laxmWoJvrY
         A8PoSL/fB7q2h0ty9QUrQ3ErhMC79adufhJ0HnngjHFTZE8OpDYIdXqLX8pWS9xxFE/b
         t5lheXspsCkGor6djZobbFX0f+UmvK6ceLk5xv6SmxcaS4nh/jz8KYpLA+hQHmXGpgv+
         qUgdZrqjWaaUxIe6/kkOa07HQsTl0ARxpaCbD1HW5TnNqUlJTh8ZFwv4gqVO100Vsgia
         j7mcAGrY71DWsNyIOCGZolOdegd8FyPKS/8/abu2Yb439RuJVGimrJVXvBz9zLjIY3ku
         m/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767804631; x=1768409431;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSTQ4KUiVWxTX9B5UYC0FohSYWYTxrtxwk0QjL7KUTM=;
        b=i9mCb6SPmNv+m1/HTVnbr73MrGbOLe6Wkzh/HR4wHaigXSwFn78xhUFEL7jow4l9yb
         g+wvzyAfW7fjVijZ86iNH0QJoBuw5z4lpP6ZG0TN4LJkjHnMQiWuf+x7OYa0ikgCpsAb
         VnNBEVlJYneO2OJnfFQJ5I9QTWsCOs0g04ftciPApr+tlgdpDTnsIVgYBJZhCTbQnj5U
         GH9YdxKKPlaxmLZGkHH79netNOHscUvkc8EsjPqEBh+D5R8t8czfORXbM0m+F+q4mQvd
         NiNThufGUq2D60OzTdnINTuWdgCeY5x6i2qm2CNc/OmuiDFqH0LXz/ge3Vu4WXySRtnD
         ER9w==
X-Gm-Message-State: AOJu0YzGkDATyEXAHz1wWoY+ui2nWu21dFziEY/ENeRzOVbHm7gk5Cvn
	N+/ndYmb8CwKIdBIMfH4vsf6vsJqE8CY5J6ElaPdMCSXzHkj0faK4IR2AkgkUh5GQMA=
X-Gm-Gg: AY/fxX6HIv8kaD+u8vk4hS+CyhvpQd899gGZhwIZcqZPbnu6i9UuQnPmEJbdeA9E8yr
	Fgwu1gTQhAeCHcQxBsmxA6Dpo5XgBC3WDv14mTXlMVcAeGAL2SP2iSVme0T3h/9FDjYmhfTCazk
	Sa6riRhhpsdN7e55bc5mp3oN8YArT4RdICa01Nf6W4AdZrTXbl/ovtKkF8dXbU09yhCdfbwsLWL
	dXQrlXzD3ZK2UBza4ba8P7BQ43qMOHOMiGNtMdVjEekcGiB91rsz8f1i8gu1BD4TBb/eKZ9IrfE
	kMtE6MiOJE3d4yp7bZ2KMvY7MbUsycNpaHCEeQjeF6TBaLzOJln7yttXlNbkdvddw3kWYWFbhF5
	hL9lbvR8ScrxqnShPkoytwUfMAmXs3/4CHCnNIhGAHkZfOs8x5ZibyJh/vttehRN4i+/AUgezRY
	kAoIpXCEvm7GMO
X-Google-Smtp-Source: AGHT+IGEPBCTt7sZXurao3XnNt1QoORRbvvUnmqRem8cMfzEqzLO4Y8vE8KoMsGJYRw0936GVdeCDQ==
X-Received: by 2002:a05:6830:2706:b0:7cb:125d:2a47 with SMTP id 46e09a7af769-7ce50a0039bmr1540987a34.1.1767804631140;
        Wed, 07 Jan 2026 08:50:31 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4762eefbsm4012413a34.0.2026.01.07.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:50:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Fengnan Chang <fengnanchang@gmail.com>, Yu Kuai <yukuai3@huawei.com>, 
 Fengnan Chang <changfengnan@bytedance.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc: rcu@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
References: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
Subject: Re: [PATCH] blk-mq: avoid stall during boot due to
 synchronize_rcu_expedited
Message-Id: <176780463002.77199.18373913031463054048.b4-ty@kernel.dk>
Date: Wed, 07 Jan 2026 09:50:30 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 06 Jan 2026 16:56:07 +0100, Mikulas Patocka wrote:
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
> [...]

Applied, thanks!

[1/1] blk-mq: avoid stall during boot due to synchronize_rcu_expedited
      commit: 9670db22e7ab4aefe2b2619589a47fef9d3e0c7e

Best regards,
-- 
Jens Axboe



