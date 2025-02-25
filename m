Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4361A5B9B;
	Tue, 25 Feb 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481116; cv=none; b=EDSJzRE08mNfdhFT13Mqo2o6zwhscweZQmZDnQK0ZKSal0D3HeIzAVvSrXJVeEWv5tTJYdcsVENoc8Od5qf5j60hcHYsexIV2xLBKX/jUwkGGj6W6aZqHDeAki8wKoLKSEVFpDcpBqCPCOtyL2wKUqLbONysZmG5rywpSJk1t44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481116; c=relaxed/simple;
	bh=TVlNyn10UOhOsfDb5reyqEProfJES17CfL7cj0kr9nU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMsOi9fuJ1HqEW8YKDAX57FDgrSKxqd6tVlx7MkJDRVG6LRF02QU9fnS+kKzy/EWL+xDcuzs8c8zyq61Ld1QhFXIE0HUrOszDBGCv7r3qA2OKi09DsahCfrCgwQIVopM+/11wz2zO/iG4yCND/eCLDqK8humTfNKbsS2hIUay2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvivoxQD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvivoxQD"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54524740032so5634533e87.3;
        Tue, 25 Feb 2025 02:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740481113; x=1741085913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A0JGPiOmgCbw/F87CIh3Is7mEUP2E4VCB+H+lpf/rx8=;
        b=kvivoxQDXm90qUZVbQZfCmGyBBM+fPxa/pDj81LiMXfEHqv0Kf5N4vb89UeRDrUcsw
         iZ4KGeuyJOic3khP3XPjw1Y9TpRo8g3ZrkRuVfSYOPYD/DSp6mw9p0yNznjVlYYkZRzA
         ARNvxQ9ml/nHewthklS3NqP7Wsu8maRQTIqJlBGscg+tsIP3sa6jU+dFx9RCs2X4t5PK
         iEf9o21LSv142QyyLWz3gMaTsHDgFTIz7P4YHt3g3YAer40MDZFHSJhFDqH0ulfP8+jG
         3083EXdiRfEVD5goCiAMNClqcRtRD1GIdkJVJtIJRk1qQayAFgwAw33m6H1Zq+HMmh1r
         I2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481113; x=1741085913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0JGPiOmgCbw/F87CIh3Is7mEUP2E4VCB+H+lpf/rx8=;
        b=B+RerslHNVysxo6YqQ3syds9QShwpY5h1Jk1/M+g3vrjT8PA8THuL6lIXN9aPN8tk3
         qad70yA95t29pc8PhTJTzQEk/uWHqgj+b/CU0Owsrwooue2fp/3R4ed1qNatn+YVFbLr
         EAWrHYZwIAFGuqnc4AJltra1j2BKq7EE7QVwa9sUXIvwwI1a0HtuoT/BGiIZgWtsIOf+
         TWTyyp2gSD8EljlfFFIhzxPgQYpRV43vG5iagZh5Bi88A3TQkG2Zodb/hwYcQqbtBz8V
         uAmm59SG0xzgCZvmXVLunflXr149cRN0AYgPC/iFH07sxlU8CtkQBImCi/zOjKGkOBgs
         3kIg==
X-Forwarded-Encrypted: i=1; AJvYcCVX3D+DVYVoSnvRK/Piq0y0AQZJzWdm/iE56wgidVBiKAzwzFOcQ/r2I65DWb6EXM+1+EBRt7iaA1W9V1k=@vger.kernel.org, AJvYcCXD1Koo7ZgKihc4gGlhYQIZNP3Qjs2QV+eE870NMgTU2rm+sRnWvBjMI/Jv1mfkeS1Yp8OJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLOXSt11Kqi7GS33SGrKPoG/oU7jA3uiPqqy9py56cBtvbz9y
	WULS1l4ejO1C+rheZcvbxcE+xGJKYKhcvWSo4+UVFIwUw089pV1e
X-Gm-Gg: ASbGncsk2HtX1wMY2JTNhouE35TBU6xgDFmc4nDzY6tPmz3EBxhs5/aRe73sxrGbfli
	e2tDbk9jRgkUZvehRkT38dJo3XzVmJE9v2XGCGhTeBJURqT8gvsahOAzFbo8L7/AIkdzWUqyawW
	jJuS/Zv8v3Nif904mQhCWL8amH9fvN5z0RPOAlCIK9/5bzPulGLYvqkCKgbHQmCPRNdAKQlRQl1
	C28KfJ6jD7TNzfvuhOW7H8tTvSUV4lBMV8ClZAJG12hPBHF5K9lPrmDszde+nSPBofcZu/tFamk
	44bTR9/L8534IDlsu51EiPGDm13uHFu1omhUm3f2Hbn4RNAM
X-Google-Smtp-Source: AGHT+IFqRMF/ZEp84MklHdhBOMn2RmvmaEjMttQo5Zdw9ZrcnY4Yb1/NHEuPf8tpXnsL42cA+TvrQA==
X-Received: by 2002:a05:6512:2247:b0:545:f1d:6f1f with SMTP id 2adb3069b0e04-548510dc14fmr912005e87.26.1740481112614;
        Tue, 25 Feb 2025 02:58:32 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548522a6368sm110451e87.255.2025.02.25.02.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:58:32 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Feb 2025 11:58:29 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/3] rcutorture: Allow a negative value for
 nfakewriters
Message-ID: <Z72iVbIZJ4jAMz4j@pc636>
References: <20250224133659.879074-1-urezki@gmail.com>
 <c299a0b1-3271-4229-bdb9-2d4904ac0e13@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c299a0b1-3271-4229-bdb9-2d4904ac0e13@paulmck-laptop>

On Mon, Feb 24, 2025 at 10:41:03AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 24, 2025 at 02:36:57PM +0100, Uladzislau Rezki (Sony) wrote:
> > Currently "nfakewriters" parameter can be set to any value but
> > there is no possibility to adjust it automatically based on how
> > many CPUs a system has where a test is run on.
> > 
> > To address this, if the "nfakewriters" is set to negative it will
> > be adjusted to num_online_cpus() during torture initialization.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
Applied and i will resend a v3 :)

Thank you!

--
Uladzislau Rezki
