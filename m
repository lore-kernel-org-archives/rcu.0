Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAFD1922FD;
	Mon, 25 Nov 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533514; cv=none; b=CbCP+xBMlEWAF108w2sLpIYHRFD35BIaTwM0R5oYhwmSv4oROhXS7+zlirgushhUX8cx7oDmnX1jyQ0HS25YB83Fwu/iM0VhAqyRQeG7vOaMabZYx6cNZRo8j4uac0AYOicnWVR9e8G3qB2Hr+DvjRAKaNK6U5G5KkeR7kVBFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533514; c=relaxed/simple;
	bh=6B04KsZo6t6s0pI8aF1kaG1Lzd9HUwRpD74QomBAbcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICvIUZGlNU5lyumXJN6BTr6mpp+6NYgX78c1RSOaVqttKxM0ODnXC0zQqE0rDbrNhQ7yk389w05iDrsGgPSXffcaSsQPoQHYMxKTPeiN3ExWFVrGpOSHvV4fTNHRZVunoRFcE6DJHCdLTNPxIROqpAg6SiWgFVfJeLWyYrCCxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQL03Ujf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQL03Ujf"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffbea0acc2so10582821fa.1;
        Mon, 25 Nov 2024 03:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732533511; x=1733138311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdTs+yXvHV2VkvZOleuVL8AIilS9h/9TJ0CS202URO0=;
        b=iQL03Ujf/pH0GISur+awajdxELajdcEeLSBT2+vVYYr41sm1thyfzhzsoTOZ+LWB5t
         S/cwROSTjTts5RJYRa/J4GqMl24KL7oCvldwxh5D+9G6TpxDLyrn5xbTnO9joZCgOKzx
         qKTRpJp8Uy4F/UrZE5DM5ojDNpm8o7h5y+VrDEt90gPq/LAZkwmvThm7aVGVTeB36M/T
         dUc8d+l9WIRVFLnEO2iJDBjZ+UXNcKMNcJBmVCGszEInw8AQ/gi568t6R0HBLH73f91n
         jk/uzG4x7AGqaYr2iF6N3ayTIDOQ621LPDr+l2Uvwty+fpBiWsScxuemljGINkH9p6L7
         8oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533511; x=1733138311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdTs+yXvHV2VkvZOleuVL8AIilS9h/9TJ0CS202URO0=;
        b=vMk1dLHsEEVil2U0ZQhzTg6OQFdruCO5zMR0HwR8YI/Ve8m7Oa+u7icgCGvfCb/6ho
         754Gxn+QlMmU35LdM2iXmQgxLCd0FPmZD4JnB4AGVzM/uX9WGfqjZDzXHe0k7zzIzucH
         DYKOPdhptDlVasuovzZkCEXfR8WakTGYQWpnZAq1i2yuV4kTtQ6Wxi2aqVugE6bgU1IF
         Qm+A2gzE4KyIqJUHbAYVI4ySz3ITUiQ2AiaiJf5WF4HqMEVhpc2hyQJ15+KWvJKMq3ma
         CVszuP1LGcBVucK+WDh0SpeAvh4JEsHs2zwi/JgiI4lLUA/RnrVrTzdH9fpWoAei3VrL
         dMHw==
X-Forwarded-Encrypted: i=1; AJvYcCWp10TZ1OEc4SLHhf/DXRWS7BdXhrMUquQ4KeNSEDawTlFE8Sef6z8X8SL+w3RH8eR3X4tM@vger.kernel.org, AJvYcCXVe5PR6bhBO91SKViMfj4kxpwSjqesTMEUO0UwccaAYApcnvbVCn5dgvIWP4zoYFZfkrOma7g/t2z//TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8fHqOYJ3Wu98tYmTNde5EmHqIqS5W8aq6foBtTcUSYSM+kSJ
	zE+jDFeIs8fmHB6Twj3f0FWPZCz9ZgLr2peHhnVSQ7TqQCRn5vqU9SNK1yxao80EGzPML86rP+h
	1a3+eqKsbhKHhGLoCu8X+x4zJzMU=
X-Gm-Gg: ASbGncvHqBMkcv4TDSCSBp5a4OMuNDstP2rb+uUhiuWSphrLHfnlgPN7VLUJ6X9gnNy
	ubSQmjwwB986wcr837mLOLeiB2zlxcjM=
X-Google-Smtp-Source: AGHT+IGrV2G7XuEDge18atcEwTobuvAC/IfIeeHl5buAnYkMXfeXyvtF4Gz6f1OITlD/141JIhoAwC2zgZbcvFEfhmE=
X-Received: by 2002:a05:6512:3ba2:b0:53d:d139:6c21 with SMTP id
 2adb3069b0e04-53dd369fbbbmr5835086e87.18.1732533510747; Mon, 25 Nov 2024
 03:18:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
 <20241112-slub-percpu-caches-v1-2-ddc0bdc27e05@suse.cz> <ZzYsBu_rJWSAcAYf@pc636>
 <cc7f24b8-4de5-4023-b40b-5f62287aafe8@suse.cz> <Zz3YDI4Bb04opI2d@pc636> <a4bd2aef-6402-49e0-9ad6-f353c5200ee7@suse.cz>
In-Reply-To: <a4bd2aef-6402-49e0-9ad6-f353c5200ee7@suse.cz>
From: Uladzislau Rezki <urezki@gmail.com>
Date: Mon, 25 Nov 2024 12:18:19 +0100
Message-ID: <CA+KHdyXH5X=J2ontChFVUqFx15=VVng23H4gh_o-2Vzfo+mmjw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] mm/slub: add sheaf support for batching
 kfree_rcu() operations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> On 11/20/24 13:37, Uladzislau Rezki wrote:
> > Thank you. Let me try to start moving it into mm/. I am thinking to place
> > it to the slab_common.c file. I am not sure if it makes sense to have a
> > dedicated file name for this purpose.
>
> Yeah sounds good. slub.c is becoming rather large and this should not
> interact with SLUB internals heavily anyway, slab_common.c makes sense.
> Thanks!
>
Got it :)

Thanks!

-- 
Uladzislau Rezki
