Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50155165EFC
	for <rcu@vger.kernel.org>; Wed,  4 Dec 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299307; cv=none; b=HW8v4lTpf9nk7kPmddzvyggUnmoupBaEw/71SaBbis3vz4wKZf9LSU9hrO2FuC/Bn2obrXOY1HSsn1Py2/N+djUFJxR5xs51VwJr/1Di1ub+hUVXzegiEbvqYxNwzRpifI7KHMjAR/TDteZ1el7Gf+SZt8c/UTf9CrEQMESO1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299307; c=relaxed/simple;
	bh=waJ5W/yBO4GBh8KGfnv89gd1Yly76ZZNZhG+kal27XI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhUPEtAXcSXMeUAZ2Rk2Hlkf3kbLXA5HY1QfZAY0Abcv7LRhlapoejauikpd8KSsPKBfiJspSVBX7JqKtSmQrqL5ajl9wKAlgPN/og2D8zi/Dk1J+IVghTLqiY3sUqOOi/evABH7zCFvxAGX+BtoIIGT4ypVnD2u85Z18KhSpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAueKe+K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAueKe+K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733299305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=waJ5W/yBO4GBh8KGfnv89gd1Yly76ZZNZhG+kal27XI=;
	b=dAueKe+KmLUud1eWZe2LbRvJsB3FmHIATtryu60pw57ttwMjzSRa8bMRomlAO7erOo7/vP
	930o3mb/KYnJPjdBEGyPUHKWz1LDa0P3QauRj51QMioHN/LNq5qqLoYbLKrbDLWI0sUNHB
	juDj+qMJ1DqInmwCcePfQ/yim3vjIgs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-_XUBTDpWOfS0FutvhVzLag-1; Wed, 04 Dec 2024 03:01:44 -0500
X-MC-Unique: _XUBTDpWOfS0FutvhVzLag-1
X-Mimecast-MFC-AGG-ID: _XUBTDpWOfS0FutvhVzLag
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8858be197so78588446d6.1
        for <rcu@vger.kernel.org>; Wed, 04 Dec 2024 00:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299303; x=1733904103;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waJ5W/yBO4GBh8KGfnv89gd1Yly76ZZNZhG+kal27XI=;
        b=ZIp1eO0RpX7eWYCGBhhIxf4nBP/X+o3rluBiOVyo8XND5W3oHnPekYJiNFh2t+TDWl
         REeL+DKu3GMqKMJZKdvFEVfOO0/ra4uSxP7Gx43d2WzNGHY//USJwCBu0YiteGS/ohU8
         76RUKrIYwcJQF6MHQe+XzVjwBXARC8BESh45NtWixapojpV8J6ujOWti37EI+/X3AW3r
         v8vtm/D1bV4W2ZjROL4VBHwi7fzMu6RWGVUWcwit2q47/ihG8r86l4D/4aJeDbkeodp2
         46baeO0sJFPVgqUgR2aKUJJOz+wg9r+yu6Jd9xlPiPtJUTWfp+1AuitAMsQs2UaOqEdx
         WUwg==
X-Forwarded-Encrypted: i=1; AJvYcCWIZD3H0KjU6mJiQZjOKyqPRsZYb/hCBJc27SLnGZaOwoAVR866fcsxhFQ7RAwQz2+n45w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0whvWI9YB7U20VT9iRuQjvMG/XCN5z0JV2K97rZ5HmQ3Z3F5Q
	n70Cuacc67AwOpwIAydvL/vwOs5NF6XzlO+Jhx6xqLPS8Hs4aOBL5hE/WDvBm6nmaHM1SPv0+MB
	G9lU3KQcUbG6WndMt3YvHM6m7q2bzbSiO0ZCAEUnYWAk/BxW3yQ==
X-Gm-Gg: ASbGncsFu3PDRk4sJke0CkZIYGDZp6DMVBmLPdENGylpY7F6ax2+yXz/hYRP0mz4a+U
	T1a/8f3khzCj+9+cGys85DVtuSZKXQF0ZSaSlr2/zXyh5+6n5xYulBalz6Y+NnpS7V3k44z76u6
	4+fOlfkEka2Dq8YPwuDZFhx4h6714EWhZEoQkHvqZv+vXLDCfycroURN1QMP4DP4/EPRDJncWC0
	Lrwtqc0pfjq0Pqil0ihXHD2Ba8j94+Iiv2ORhRZOGNanH62qawy81Sq/c0LdlHZI4GQH/C2Paq1
X-Received: by 2002:a05:6214:2aad:b0:6d8:8fdd:9791 with SMTP id 6a1803df08f44-6d8b73b65eemr99368236d6.25.1733299303575;
        Wed, 04 Dec 2024 00:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhiXpMva47idGqFj5GtbBNZmdu1R1vo3wasWbHy6+dTkb4iz+yeUGZIRXwuzqkuGPteOIYbg==
X-Received: by 2002:a05:6214:2aad:b0:6d8:8fdd:9791 with SMTP id 6a1803df08f44-6d8b73b65eemr99367886d6.25.1733299303243;
        Wed, 04 Dec 2024 00:01:43 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8afe44481sm25181916d6.72.2024.12.04.00.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:01:42 -0800 (PST)
Message-ID: <81cc8be1b5fe76a3323c2990994442f7e7959629.camel@redhat.com>
Subject: Re: [PATCH 2/2] sched: Move task_mm_cid_work to RCU callback
From: Gabriele Monaco <gmonaco@redhat.com>
To: Joel Fernandes <joel@joelfernandes.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall	 <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, paulmck <paulmck@kernel.org>,  Frederic
 Weisbecker	 <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki	 <urezki@gmail.com>, Lai
 Jiangshan <jiangshanlai@gmail.com>, Zqiang	 <qiang.zhang1211@gmail.com>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Date: Wed, 04 Dec 2024 09:01:36 +0100
In-Reply-To: <CAEXW_YT1NLU2xsBHwDjbBPg_rZWc4hNGNgmkdxF8C_0Dw60N1w@mail.gmail.com>
References: <20241202140735.56368-1-gmonaco@redhat.com>
	 <20241202140735.56368-3-gmonaco@redhat.com>
	 <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
	 <CAEXW_YT1NLU2xsBHwDjbBPg_rZWc4hNGNgmkdxF8C_0Dw60N1w@mail.gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Tue, 2024-12-03 at 10:00 -0500, Joel Fernandes wrote:
>=20
> Also there is no guarantee that RCU callback will run within a thread
> context (example, some configurations run it in softirq). Further,
> call_rcu() usage as shown in this patch can also delay callback runs
> by seconds (with RCU_LAZY enabled).
>=20
> See also #5 in checklist: https://docs.kernel.org/RCU/checklist.html
>=20

Thanks for the tips, I get the RCU callbacks are clearly not the right
place where to put this function.
I'm working on a V2 where the same tick is scheduling a new work_struct
in the mm_struct instead, let's see where that brings.

Thanks all for the constructive comments.
Gabriele

