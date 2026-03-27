Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27833C187
	for <rcu@vger.kernel.org>; Fri, 27 Mar 2026 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579682; cv=pass; b=uF3nLJZHDPAD8B/6XRrLvmPhDC0ryDEb9R/7Y7MidGzmSFFL4A9awBGBXnawH5kpA039obOpoP4gFk8+VQ59gqgcj3NHAFlIRCt76R5O1U8SAY2DN6DaVkhoNloGRoQb+8kMDwA3/orTtokNhu6kYnwM3m9yA29Bcep9vbG5uzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579682; c=relaxed/simple;
	bh=ZLlqX+0XXIywDxmqLIh40E7QiUExlR8czunsHevc1Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=W601EL4AzL1nZND2+mDd0n2UfKgV+1DsywWbLxgbW2ITIj2KxJR1q7snNejURbg3Dd352qwbGqWJPlkDjcFFPUzc9GyPxzRx5AmpfFJ9r0le6Mxn93cd/uhHg2ZkWCZq/KcluXWCOx9Hwdvpr5oG6LsjzcjyDKgPldrnLhNGqlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqdWWM16; arc=pass smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqdWWM16"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so210656866b.2
        for <rcu@vger.kernel.org>; Thu, 26 Mar 2026 19:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774579680; cv=none;
        d=google.com; s=arc-20240605;
        b=h1xLqDT6P+yZ2mggfbhTI6fRxUrXx2IGF3NXFLwBRRT1+qN1NxpNSpvxRVNG3jQdzS
         HYvp4V3DKGbhfqdRMz9+lWSzAxj9p5rfsbaagNTrv+CG/YHzGGnR43pKJdEFg/JGqL4x
         m4AgDNDFEJLNC48LnM5jR3TkvfoE79IvZQwppzFqz48JnN5eFWsmTg8/U0SuocpqzPwf
         gtLaLG9GeglzP2gvEbZMuImqq4r0RZZTz9XBi7r4dPydhmmYU3SWgNkJXrj6af5rE73A
         u+wH1lmTQkJbGBgowGnpO33R8IfAY7ajcdiG1iQp0cjTDbRigHC63bgw9DVGSSxQ8FZA
         cBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BlfyXUX6gjmSlSlJChRNEecXdllpT7D98/cgS8kOMJg=;
        fh=pp4N3kmCLxdn97tgh+qBfi4opskx3MQhaugPCBdoU70=;
        b=PNKGzSDGs7+ox0lOx0ByCOzP8j8KUEqqUqgFC7YEjJ+kWVPcXevAkJMf9DTwLTKOI8
         S3mcwwuZXEYet3BDlGL/guRW21rHZIj3eN3jkZkjmx0GEqSfejT677eUaT+6vQfU/BGX
         SCENYqM2rH7yTpJco+tHBcndJn5o7haydFrYjN/OPyT1KbujkusdkPjLQgd5LXR1fZ54
         MjL6TiPzDfzNSv4L5aVR6b61N/uCjwQ9+kihsXisyn1OyeJIzlLIiIcV338Q6Wrq7uec
         qlfPpew7ZV5nisr93ajQqA0U0NyGSmXnGCmaqjBhpngdOxLcc704JdYqr2rb/E2FgvTW
         IZOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774579680; x=1775184480; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlfyXUX6gjmSlSlJChRNEecXdllpT7D98/cgS8kOMJg=;
        b=FqdWWM16VDM+kkOdecYm4aCAGvBOr81vZSEtVAXLnOtToo7S8ph6S1TQQAxEZufh+8
         YMpFHZXsOkqjaUq0lMpAyJS4Pum/UyxMR503YN9tDZJncrE76AdRcGZR+7JOAD+niSgZ
         H7LHVz3k6vOFES6BdWoeUj0pTUta8KH9BJjxB55fbCXt1ZSZ0mAf9So1Efa0qGrvlbrR
         PeB7gYJjjv3f/MBpxwPBjicOMNS8EdmETtazBnuMc4hYb0DhXgDvkm8SmnqPQWRSLPxJ
         vhJ2BXhIOociBSwXp6kVn1cH+kkZ6ZNDkbomcO7yc/VTWhmxtA+KOe7tm46zXubggxm8
         zbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774579680; x=1775184480;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlfyXUX6gjmSlSlJChRNEecXdllpT7D98/cgS8kOMJg=;
        b=MKTchjkOY1V0Z0yCdMsruoxeR8H/TXK2rPB1Sz7NH6mdZW/T7Ua7ASa//GqvP19FnX
         HNkoUCQNx+metheIOi/OlEq1kqo4m38nJIF3kkwUEaUBZUhPKpDApnrIK612ybkJI8ll
         +LxFSOYacmw7q2f/Plf9cs6WrJvSHttZJtxEVTmM4+Gxnfjvp/WDBx+dVG0C4skno6ih
         4+dsj2iYJT/3/0krsmJRYOCOSjnd5fdS72TQwCYuZZQpBwyaTCwqsQEtYhYZvD7zxzC/
         nW8+YXM5S3MMJ1D/sGDbUuBQRPqyytoqWuHX3E3XYime8V5XVe80FV3UDwOqnPD9rhWs
         NWfg==
X-Forwarded-Encrypted: i=1; AJvYcCXNwkh0eUC6DHeSKmCvSoanHT3ZN6wDVb7KbylC9TFQ28+naZzlw6jHrdKRTGNkE6HAKvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RLuWmjo4WXDKNswaPcB4dljnvh0ENHFkYmsgr6kVHC67gy3E
	vgHOMDH+1V+zg9ovhEsbcT8umCM2hsffFMV6QOtTSUDU6jJ2vRC3odtfffa5+c5bmukYClp8Mfg
	jcXfeXU29aBi9HvaVflVlonB0gpjWVCs=
X-Gm-Gg: ATEYQzy+p03MmM4Dm2XoVU4n2ns6x51e741YnZfSO8C6J0vGiafa0tdJQzG8CrZXi4f
	J9LjuGJQriEr5lgSkt+FwiKXLKPG2H2fW8+mIWpsMDceBdF3Rh0KGq2EgnCxbag9UKoVlpZMc7m
	8mFPFwRNdzy4ZsPnxfWyweNycOOrkxw16GPjUaQRsDesPpWwhTeRk+vDKqKWicSl/pXb1WQyN3H
	Wx0qXj7T6SAOqDlBFEcHCLZ3G5h2qoYyvcSMFy/06aghUJOO+h0RJSlxn3SwPiYHKEFAHDMbgBu
	p67AQumLGylbQg8DoNtVEWBI+cW8bg==
X-Received: by 2002:a17:906:9c94:b0:b98:cb6:e896 with SMTP id
 a640c23a62f3a-b9b50909b02mr39272366b.38.1774579679566; Thu, 26 Mar 2026
 19:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hzb6yfHwHdwMC1TTP87dbnn=BHyyWz+iCQ_EswN5jVjeg@mail.gmail.com>
In-Reply-To: <CAN2Y7hzb6yfHwHdwMC1TTP87dbnn=BHyyWz+iCQ_EswN5jVjeg@mail.gmail.com>
From: ying chen <yc1082463@gmail.com>
Date: Fri, 27 Mar 2026 10:47:47 +0800
X-Gm-Features: AQROBzDUAyu9tpNSOVMlX-OjnQJ6xVte-6P4kxe-3-vWu77CbZkBxfC_Vmu4fvo
Message-ID: <CAN2Y7hxx8OQemOiF17swXcLccd-KJ=j0P0tkWD+fQqzL5O1FhQ@mail.gmail.com>
Subject: Fwd: [BUG] rcu_tasks detected stalls in kcompactd during proactive compaction
To: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, paulmck@kernel.org, frederic@kernel.org, 
	quic_neeraju@quicinc.com, josh@joshtriplett.org, 
	Steven Rostedt <rostedt@goodmis.org>, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, joel@joelfernandes.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: ying chen <yc1082463@gmail.com>
Date: Tue, Mar 24, 2026 at 4:26=E2=80=AFPM
Subject: [BUG] rcu_tasks detected stalls in kcompactd during proactive
compaction
To: <linux-mm@kvack.org>, <linux-kernel@vger.org>,
<paulmck@kernel.org>, <akpm@linux-foundation.org>


Hi all,
I encountered an RCU tasks stall issue triggered by kcompactd0 on my
system.Below are the details of the incident:

Kernel Version=EF=BC=9A6.1.0-x
vm.compaction_proactiveness =3D 20
CONFIG_PREEMPT_RCU=3Dy

[Sun Mar 22 16:36:04 2026] INFO: rcu_tasks detected stalls on tasks:
[Sun Mar 22 16:36:04 2026] 00000000fcafb4d6: .. nvcsw: 622963/622963
holdout: 1 idle_cpu: -1/1
[Sun Mar 22 16:36:04 2026] task:kcompactd0      state:R running task
 stack:0         pid:1943
[Sun Mar 22 16:36:04 2026] Call Trace:
[Sun Mar 22 16:36:04 2026]  <TASK>
[Sun Mar 22 16:36:04 2026]  ? rmap_walk_anon+0x16b/0x330
[Sun Mar 22 16:36:04 2026]  ? try_to_migrate+0x96/0x110
[Sun Mar 22 16:36:04 2026]  ? try_to_unmap_one+0xd0/0xd0
[Sun Mar 22 16:36:04 2026]  ? anon_vma_ctor+0x50/0x50
[Sun Mar 22 16:36:04 2026]  ? folio_get_anon_vma+0x90/0x90
[Sun Mar 22 16:36:04 2026]  ? invalid_mkclean_vma+0x20/0x20
[Sun Mar 22 16:36:04 2026]  ? __unmap_and_move+0x21e/0x340
[Sun Mar 22 16:36:04 2026]  ? free_unref_page+0x17d/0x1f0
[Sun Mar 22 16:36:04 2026]  ? release_freepages+0xc0/0xc0
[Sun Mar 22 16:36:04 2026]  ? release_freepages+0xc0/0xc0
[Sun Mar 22 16:36:04 2026]  ? unmap_and_move+0xaa/0x4c0
[Sun Mar 22 16:36:04 2026]  ? migrate_pages+0x3a9/0x790
[Sun Mar 22 16:36:04 2026]  ? release_freepages+0xc0/0xc0
[Sun Mar 22 16:36:04 2026]  ? isolate_migratepages+0x2a0/0x2a0
[Sun Mar 22 16:36:04 2026]  ? compact_zone+0x310/0x5d0
[Sun Mar 22 16:36:04 2026]  ? proactive_compact_node+0x88/0xc0
[Sun Mar 22 16:36:04 2026]  ? kcompactd+0x365/0x3f0
[Sun Mar 22 16:36:04 2026]  ? membarrier_register_private_expedited+0xa0/0x=
a0
[Sun Mar 22 16:36:04 2026]  ? kcompactd_do_work+0x2a0/0x2a0
[Sun Mar 22 16:36:04 2026]  ? kthread+0xeb/0x120
