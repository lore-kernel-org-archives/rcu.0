Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C018B48C
	for <rcu@vger.kernel.org>; Tue,  3 Sep 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380433; cv=none; b=un/GnCwFKFu8Za5iWi5EI5RPIhcf+FOUO4BX2sGjpsipWmvKoSAZ4r/1OJPAYY2GM8Tqul7oTC99XhCjHNVMI6ztQJUI3Xc6UhJxPi2Rf2b/ua49O0gqDDD9dkeVINbLcxK7rnslZf9R7MWd6OHNhKKbalwskljpINok7AfZysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380433; c=relaxed/simple;
	bh=OAPXgA26vcCvFh11octbJS1kd1LOYAh0ZLkW8SJrsuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lh7JYQRMfXyI8IIb9ncgE/Kg1/is43sCFKlUEhVLj+iR017I31JRPnBZi+wRcnf7zknujpDEyIlrDOTcTubbE7UoxOA42+Gs/GGJbYP4crICz+EVxwyBl8sXHoCYSSA4uSXn6OjmNIUZOibm9SpS4SSZeebKp3QR5xoY4fXKWf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDEpuqsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDEpuqsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725380431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdmA5Tid/74wv02V6AnoSmfNmJjNITfTGTTXlL20Rx4=;
	b=YDEpuqsvhzdT1cWKo5UDkiLqKXKh22eEE9koU0zFsIY9eLjzRggk3t42tU3qYhmBK1IDu/
	0N30WyCr/Y6C3KDMr1ynI/87XEPDWnhUDszgGotqt2Y6uF9VsdAPIexroUq646dzlB8nSW
	gk+iVYRF9wPvsGNeBrUlXYhVDjbL6Cc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-WSoOc-PEOrym2Dwx032E-A-1; Tue, 03 Sep 2024 12:20:30 -0400
X-MC-Unique: WSoOc-PEOrym2Dwx032E-A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so4282045e9.0
        for <rcu@vger.kernel.org>; Tue, 03 Sep 2024 09:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380429; x=1725985229;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdmA5Tid/74wv02V6AnoSmfNmJjNITfTGTTXlL20Rx4=;
        b=RlQI6bgagE9WFXchnjUSQYj0yVis4nj8fRFAOpCQ4r6eDwK8k0Vuid+llN/Yk3Mly3
         OfyrW1RTM0WncfGdBFY9/Kw9+szHKh8MwXPSQCf4nGsqtnAi08vpkzSVdKcVLDNfH8M8
         Kwq10u6d0KNax0tQXsC0W5JYXLwqRY0zzcFz0/VdqDqj4kjkWrGDldTHJoQcxNqjQvIV
         gdymvIbz7Yz5GpHe66scHHySg2KR+4UP8dRMEwcFREpS/obEBIfv7pF6CWeEGpCmIHIQ
         65GB9762CZAqY6o7zHzOAHCLf7/BCiFzJEye0duBXPLPCvaN43C/9rnNITS6IiTCrvR4
         /PuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCMf71DR9X0WGUYqA7mpiwngLpshtlMmtRpxx0WAe2Ub1zMWczI+z32xRqIjONkKX7/eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwVJZ9rXGoP7XZvZflW5idbbTvFNapoJfv6qOT8V8T5sh4I+X
	chCTKxvRCnrLNhWKEXvbJe7VjXdonK4mOUOhJbsQsiEzNK5Ui+kHByUUwpzpyOaDjCfgMkZXYIg
	bCrL9tva52Z27Wf7Sw1p69DZ6JyVZNwOjDjNqwbjl5JdZfnERqw==
X-Received: by 2002:a05:600c:154a:b0:428:1b0d:8657 with SMTP id 5b1f17b1804b1-42bb01c1136mr133191305e9.22.1725380428993;
        Tue, 03 Sep 2024 09:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt969PrCDn6htrQ/H40UrhQS7X/fYPo/AjcJYavG+h5+5YVtDQLDh+BGH5pAZgb9g0m3LBUw==
X-Received: by 2002:a05:600c:154a:b0:428:1b0d:8657 with SMTP id 5b1f17b1804b1-42bb01c1136mr133191155e9.22.1725380428491;
        Tue, 03 Sep 2024 09:20:28 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbef54b23sm141833145e9.44.2024.09.03.09.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:20:27 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian
 <kevin.tian@intel.com>, Yiwei Zhang <zzyiwei@google.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <Ztcrs2U8RrI3PCzM@google.com>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com> <ZtUYZE6t3COCwvg0@yzhao56-desk.sh.intel.com>
 <87jzfutmfc.fsf@redhat.com> <Ztcrs2U8RrI3PCzM@google.com>
Date: Tue, 03 Sep 2024 18:20:27 +0200
Message-ID: <87frqgu2t0.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Sep 02, 2024, Vitaly Kuznetsov wrote:
>> FWIW, I use QEMU-9.0 from the same C10S (qemu-kvm-9.0.0-7.el10.x86_64)
>> but I don't think it matters in this case. My CPU is "Intel(R) Xeon(R)
>> Silver 4410Y".
>
> Has this been reproduced on any other hardware besides SPR?  I.e. did we stumble
> on another hardware issue?

Very possible, as according to Yan Zhao this doesn't reproduce on at
least "Coffee Lake-S". Let me try to grab some random hardware around
and I'll be back with my observations.

-- 
Vitaly

