Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A41E895
	for <rcu@vger.kernel.org>; Thu, 25 Jul 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918811; cv=none; b=oMGg2M/2fw6d5Glkfmq7sx1eHcS57Hu/dNyjzQv52f+hBmCr/5i+GJsD2VITA0ZYYqrD7iKqlXrW0qpbxbmIH3akAsYg1XfI41pcrRVjIcdsAhRm7Z3bL9APYRWUCHByLCQjGZulafNf0AQPTTKeI0Smc7P9Wd/Dg81RFZvi84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918811; c=relaxed/simple;
	bh=UXpXmJvT0va0l3p81se0HFl/LbI/kH9FMntWyqrkBcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SbJEpbKvK14t4IEZxwuIccG0Y98tESuT5hAs0A4GnPNkh05NMRM4RpH89x4qmkozRFmrFC3LkeKh6VWhyB7bhxcx+tdb2tn8yqcib8VXMk6N8/lcloyqbQvZ6vo/pnfT0eOGspJCy6SZB0hO52w7keacHvoNcZW4kf+s9Gk1BDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScaJrc2C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScaJrc2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721918808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXpXmJvT0va0l3p81se0HFl/LbI/kH9FMntWyqrkBcg=;
	b=ScaJrc2Cg/l3N1kXvp5IFQ67P4zrUAaqhEfXzGOtIiNPt/SONlFabChTMrJRJg5HfgKvs2
	bpuCm5gAKhaWCE7Av9qNqJlp14VC8+QRWHz1aZjCESzQN8Wmv+u69kqnoRqZEQvPCApIvM
	ZFzCfMCoH7iEQAJ5gEazgVSfBm8Xhv0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-oFFGQzoIPreRGl5hNGcB3g-1; Thu, 25 Jul 2024 10:46:46 -0400
X-MC-Unique: oFFGQzoIPreRGl5hNGcB3g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-426683d9c4bso7451135e9.3
        for <rcu@vger.kernel.org>; Thu, 25 Jul 2024 07:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918806; x=1722523606;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXpXmJvT0va0l3p81se0HFl/LbI/kH9FMntWyqrkBcg=;
        b=obRwE6tAL7t2Z33lG31+H55b0Ra2wXlQ5x1eZ3O6b+HI2AbB6pTo6xB+tbBrbwxBEH
         p4kJn4y8+ug5EH4M5M+lAuU4FdT278B9/8RunL/mptHr3uApyRsdfTA5tvih927jLbHp
         UYpiF21ItP9s+yCKZqvx885HnOtJMFcYcYh1B34ir/DcCjNpbsmccyo05MCA8zXwnj63
         1BR6FdU1pBuJZo3hxk30TOzuteiq40v2h9eb1k+eU7cZZdmCQzV3QWSIq1xxPbEVp9ad
         Dqt4caNJ/xqVQto9J/jZOMjypV4z4/f2ARW/OJ5mCFV0bQeSfBTWQR1gdO6bwgrPmsPl
         gCSg==
X-Gm-Message-State: AOJu0YwE6qKnCPdAkSjAT2ttS6c4jvmJSnqwBKZKyDQ7t0ERHEiU72pv
	cFxQ3cofxrUV7o+ck2/3UjFQs8rsPT20gRBqE8XHQ8YkFpBwzIL6pqUOenaYls9eMD2LemuMzli
	F+VdMyLokdgBtkXnJz5e2tFrP2CBAk8DscL7shGayUblZ9pEo8A==
X-Received: by 2002:adf:e281:0:b0:366:e64f:b787 with SMTP id ffacd0b85a97d-36b319dbda9mr2129995f8f.8.1721918805889;
        Thu, 25 Jul 2024 07:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK86Bkeo6mGzPN+xwCuZD5Bq8Yc6ON5LsThd8oveDep2INDu56QbTBosMfiRiBF84C7tMKtg==
X-Received: by 2002:adf:e281:0:b0:366:e64f:b787 with SMTP id ffacd0b85a97d-36b319dbda9mr2129978f8f.8.1721918805511;
        Thu, 25 Jul 2024 07:46:45 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857d5asm2414743f8f.84.2024.07.25.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:46:44 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 14/25] context_tracking, rcu: Rename
 rcu_dynticks_curr_cpu_in_eqs() into rcu_watching_curr_cpu()
In-Reply-To: <ZqJAwZiJ3oC-Kr36@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-15-vschneid@redhat.com>
 <ZqJAwZiJ3oC-Kr36@localhost.localdomain>
Date: Thu, 25 Jul 2024 16:46:43 +0200
Message-ID: <xhsmhcyn1zfzg.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/07/24 14:10, Frederic Weisbecker wrote:
> Le Wed, Jul 24, 2024 at 04:43:14PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
>> RCU_WATCHING, reflect that change in the related helpers.
>>
>> Note that "watching" is the opposite of "in EQS", so the negation is lif=
ted
>> out of the helper and into the callsites.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> You may need to update the patch title on this one.
>

Duh, there's a few of these, sorry about & thanks for spotting them.

> Thanks.

